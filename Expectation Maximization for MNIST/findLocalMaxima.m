% [mask]=cutPatches(H)
%
% H:     3-dimensional array with arbitratry values
%
% Return a mask with all local maxima.


function [maxInd, maxVal]=findLocalMaxima(data, maxThresh)

dataSize = size(data);
mask = ones(dataSize);
for k = 0:26
    if (k ~= 13)    
        shift = [mod(k,3), mod(floor(k/3),3),floor(k/9)] -1;
        mask = mask .* (data >= circshift(data,shift));
    end
end
mask(:,:,1) = 0;
mask(:,:,dataSize(3)) = 0;


maxInd = find(mask);
linInd = maxInd(find(data(maxInd) > maxThresh*max(data(maxInd))));

% mask = mask .* (data > maxThresh*max(data(maxInd)));
% linInd = find(mask);

maxInd = convertLinearInd(size(data), linInd);
maxVal = data(linInd);

end