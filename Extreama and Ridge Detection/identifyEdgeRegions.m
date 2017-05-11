% identifyEdgeRegions
%
% delInd:   The indices of regions that are deemed too close to the edge of
%           the image
% imgSize:  The size of the image input to the region detector
% roiCoord: The coordinates of regions detected in img (one coordinate
%           vector per row)

function [delInd]=identifyEdgeRegions(imgSize, roiCoord)

roiRad = max(roiCoord(:,3:4),[],2);
crdLim = [1,1; imgSize];
delMask = zeros(size(roiCoord,1),1);
for i=1:2
    for j=1:2
        edgeDist = abs(roiCoord(:,3-i)-crdLim(j,i));
        delMask = max(delMask,edgeDist<=roiRad);
    end
end
delInd = find(delMask);

end