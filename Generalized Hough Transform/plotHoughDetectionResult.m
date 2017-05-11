% plotHoughDetectionResult
%
% img:          Grayscale image
% template:     Object template (binary mask and complex gradients)
% objectList:   Coordinates in the hough space of detected objects. Each
%               row describes one detection (with four coordinates).
% scaleSteps:   Resolution of HG in the scale dimension
% scaleRange:   Minimum and maximum scale considered (e.g. [0.5, 2.0])
% angleSteps:   Resolution of HG in the orientation dimension
% angleRange:   Minimum and maximum angle considered (typically [0, 2*pi])
%
% Visualises the result of object detection.


function plotHoughDetectionResult(img, template, objectList, scaleSteps, scaleRange, angleSteps, angleRange)

imgSize = size(img);
objectNum = size(objectList,1);
scaleIncr = (scaleRange(2)-scaleRange(1))/(scaleSteps-1);
angleIncr = (angleRange(2)-angleRange(1))/angleSteps;

colormap('gray');
hold on;
image(img(imgSize(1)-[0:imgSize(1)-1],:),'CDataMapping','scaled');

for i=1:objectNum
    objCoord = objectList(i,:);
    scale = scaleRange(1) + (objCoord(3)-1)*scaleIncr;
    angle = (objCoord(4)-1)*angleIncr;
        
    binMask = abs(ifft2(makeFFTObjectMask(template, scale, angle, imgSize)));
    binMask = circshift(binMask, objCoord(1:2)-1);
    
    maskSize = size(binMask);
    edgeInd = convertLinearInd(maskSize,find(binMask > 0.1*max(binMask(:))));
    
    
    plot(objCoord(2), imgSize(1)-objCoord(1), 'gx');
    plot(edgeInd(:,2), imgSize(1)-edgeInd(:,1), 'r.');
end
xlim([1,imgSize(2)]);
ylim([1,imgSize(1)]);
hold off;

end