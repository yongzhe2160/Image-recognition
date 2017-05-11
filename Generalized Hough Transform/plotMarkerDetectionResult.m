% plotHoughDetectionResult
%
% img:          Grayscale image
% template:     Object template (binary mask and complex gradients)
% objectList:   Coordinates in the hough space of detected markers. Each
%               row describes one detection (with four coordinates).
% scaleSteps:   Resolution of HG in the scale dimension
% scaleRange:   Minimum and maximum scale considered (e.g. [0.5, 2.0])
% angleSteps:   Resolution of HG in the orientation dimension
% angleRange:   Minimum and maximum angle considered (typically [0, 2*pi])
%
% Visualises the result of marker detection.

function plotMarkerDetectionResult(img, template, objectList, 	scaleSteps, scaleRange, angleSteps, angleRange)

imgSize = size(img);
objectNum = size(objectList,1);
scaleIncr = (scaleRange(2)-scaleRange(1))/(scaleSteps-1);
angleIncr = (angleRange(2)-angleRange(1))/angleSteps;
templateSize = max(size(template));

colormap('gray');
hold on;
image(img(imgSize(1)-[0:imgSize(1)-1],:),'CDataMapping','scaled');

for i=1:objectNum
    objCoord = objectList(i,:);
    scale = scaleRange(1) + (objCoord(3)-1)*scaleIncr;
    angle = -(objCoord(4)-1)*angleIncr;
    
    edgeVect = 0.5*scale*[cos(angle),-sin(angle); sin(angle), cos(angle)]*[0;templateSize];
    center = objCoord([2,1]);
    
    plot(center(1)+[-1,1]*edgeVect(1), imgSize(1)-(center(2)+[-1,1]*edgeVect(2)), 'r');
    plot(objCoord(2), imgSize(1)-objCoord(1), 'gx');
end
xlim([1,imgSize(2)]);
ylim([1,imgSize(1)]);
hold off;

end