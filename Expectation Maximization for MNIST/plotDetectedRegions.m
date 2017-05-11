% plotDetectedRegions
%
% img:          The test image
% regionCoord:  The coordinates of the regions of interest in the test image
%               (see detectExtrema.m and detectRidges.m)

function plotDetectedRegions(img, regionCoord)

roiNum = size(regionCoord,1);
imgSize = size(img);


angNum = 100.0;
angles = 2*pi*([0:angNum-1]/(angNum-1));
circCrd = [cos(angles); sin(angles)];


cla('reset');
hold on;
set(gca,'xLim',[1,imgSize(2)],'yLim',[1,imgSize(1)]);
image(flipdim(img,1), 'CDataMapping', 'Scaled');
set(gca, 'XTick',[]);
set(gca, 'YTick',[]);
set(gca, 'PlotBoxAspectRatio', [imgSize([2,1])/max(imgSize),1]);
colormap('gray');

lineWidth = 2;
for i=1:roiNum
    cs = [cos(regionCoord(i,5)), sin(regionCoord(i,5))];
    crdMat = [regionCoord(i,3)*circCrd(1,:); regionCoord(i,4)*circCrd(2,:)];
    crdMat = [cs(1), -cs(2); cs(2), cs(1)] * crdMat;

    xCrd = max(min(crdMat(1,:)+regionCoord(i,1),imgSize(2)),1);
    yCrd = max(min(crdMat(2,:)+regionCoord(i,2),imgSize(1)),1);

    plot(xCrd,imgSize(1)-yCrd, 'r', 'LineWidth',lineWidth);
end
    
hold off;
set(gca, 'XTick',[]);
set(gca, 'YTick',[]);

end
