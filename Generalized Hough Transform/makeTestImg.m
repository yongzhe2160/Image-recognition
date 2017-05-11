% makeTestImg
%
% Helper function for testGeneralHough

function [testImg] = makeTestImg(templateImg, angle, scale, scaleRange)

templateSize = size(templateImg);
testImgSize = ceil(2*scaleRange(2))*templateSize;

testImg = zeros(testImgSize);

degrees = 180*angle/pi;
newTemplate = imrotate(imresize(templateImg, scale, 'bicubic'), degrees, 'bicubic');
newSize = size(newTemplate);
testImg(1:newSize(1),1:newSize(2)) = newTemplate;
testImg = circshift(testImg, round(0.5*(testImgSize-newSize)));

end