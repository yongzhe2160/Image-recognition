% findHoughMaxima
%
% houghSpace:   The Hough voting space HG
% threshold:    Global threshold for the identification of detections.
%               Threshold is relative to the maximum value in HG
% maxMask:      Binary mask indicating detected objects (1 corresponds to
%               detection). Four dimensional.
% maxInd:       Indices of detected local maxima (after thresholding). Each
%               row contains the 4D coordinates of a detected object.
%
% Apply a threshold and identify local maxima in HG
    
function [maxMask, maxInd]=findHoughMaxima(houghSpace, threshold)

houghSize = size(houghSpace);

% Compute the actual threshold relative to the global maximum
threshold = threshold*max(houghSpace(:));

% Project the space into the image plane
maxImg = max(max(houghSpace,[],4),[],3);
% Local maxima in the image plane
imgMaxMask = calc2DMaxMask(maxImg, threshold);

% Compute the coordinates of each local maximum in the angle/scale
% dimensions
[imgMaxY, imgMaxX] = find(imgMaxMask);
maxMask = zeros(houghSize);
maxInd = [];
for i=1:length(imgMaxY)
    subSpace = squeeze(houghSpace(imgMaxY(i),imgMaxX(i),:,:));
    subMaxMask = calc2DMaxMask(subSpace, threshold);
    maxMask(imgMaxY(i),imgMaxX(i),:,:) = subMaxMask;
    
    [subMaxR, subMaxC] = find(subMaxMask);    
    maxInd = [maxInd; ones(numel(subMaxR),1)*[imgMaxY(i),imgMaxX(i)], subMaxR, subMaxC];
end

end




% calc2DMaxMask
%
% img:          Grayscale image
% threshold:    Threshold (relative to global maximum)
% maxMask:      Binary mask of local maxima
% 
% Identifies local maxima in a grayscale image

function [maxMask]=calc2DMaxMask(img, threshold)

imgSize = size(img);
maxMask = ones(imgSize);

for i=0:8
    shift = [mod(i, 3), floor(i/3)] - 1;
    if (max(abs(shift)) == 0) continue; end
    maxMask = maxMask .* (img > circshift(img, shift));
end
maxMask = maxMask .* (img > threshold);

end
