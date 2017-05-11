% convertLinearInd
% 
% dataSize:     Size of the dataset which linarInd index into
% linearInd:    Linear indices into the dataset
% coordMat:     Converted indices. Each row contains the coordinates of the
%               corresponding linear index.
%
% Converts linear indices (e.g. results of find or max) to conventional
% coordinates.
    
function [coordMat]=convertLinearInd(dataSize, linearInd)

dim = length(dataSize);
linearInd = linearInd(:)-1;
coordMat = zeros(length(linearInd),dim);

for i=1:dim
    coordMat(:,i) = mod(linearInd,dataSize(i));
    linearInd = floor(linearInd/dataSize(i));
end
coordMat = coordMat+1;

end