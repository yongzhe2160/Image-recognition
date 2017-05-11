% convertLinearInd
% 
% dataSize:     Size of the data set
% linearInd:    Linear indices into the data set
% coordMat:     Converted coordinates (each row corresponds to a single
%               linear index)
%
% Converts linear indices (e.g. the result of min, max or find) to
% coordinate vectors
    
function [coordMat]=convertLinearInd(dataSize, linearInd)

dim = length(dataSize);
linearInd = linearInd(:)-1;
coordMat = zeros(length(linearInd),dim);

for i=1:dim
    coordMat(:,i) = mod(linearInd,dataSize(i));
    linearInd = floor(linearInd/dataSize(i));
end
coordMat = coordMat+1;

