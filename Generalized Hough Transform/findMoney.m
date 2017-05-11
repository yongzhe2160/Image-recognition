function findMoney()
% Globle threshold
threshold=0.6;

% Resolution in the scale dimension of HG
scaleSteps = 10;
% Minimum and maximum scale to be considered
scaleRange = [0.8,1.2];

% Resolution in the orientation dimension of HG
angleSteps = 4;
% Minimum and maximum angle
angleRange = [0, 2*pi];

% Filtersize to use when computing complex gradients
gradKernelSize = 1;         %e.g. 1.2

% Threshold for computing the binary object edge mask
templateThresh = 0.5;

templateImg = imread('./img/moneyTemplate.jpg');
if (length(size(templateImg)) > 2)
    templateImg = rgb2gray(templateImg);
end
templateImg = double(templateImg);

% Compute the test image and complex gradients (scale and rotate original)
testImg = imread('./img/poker.jpg');
if (length(size(testImg)) > 2)
    testImg = rgb2gray(testImg);
end
testImg = double(testImg);
gradImg = calcDirectionalGrad(testImg, gradKernelSize);

% Compute the object template
template = makeObjectTemplate(templateImg, gradKernelSize, templateThresh);

% Compute the Hough space
houghSpace = generalHough(gradImg, template, scaleSteps, scaleRange, angleSteps, angleRange);

% Vislualise the four dimensional Hough space
[a b c d ]= size(houghSpace);
result_hough = zeros(a,b);

for i = 1 : a 
   for j = 1 : b 
       C= max(houghSpace(i,j,:,:));
       result_hough(i,j) = max(C(:));
   end 
end    
figure,imshow(result_hough,[]);

[maxMask, maxInd]=findHoughMaxima(houghSpace, threshold);
%objectList = convertLinearInd(size(houghSpace), maxInd);
figure,plotHoughDetectionResult(testImg, template, maxInd, scaleSteps, scaleRange, angleSteps, angleRange);

