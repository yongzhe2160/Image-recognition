function testDetectors

% The path of the image to process
imgPath = 'img/t.png';

% The range of scales to analyse
scaleRange = [2,4096];

% The number of steps used to cover the range of scales
scaleSteps = 20;

% The threshold (relative to the global maximum) for extremum and ridge
% detection
roiThresh = [0.5,0.1];

% Read the image to be processed
img = imread(imgPath);
if (numel(size(img)) > 2) ,img = rgb2gray(img); end
img = double(img);

% Detect extrema and ridges
extremCoord = detectExtrema(img, scaleRange, scaleSteps, roiThresh(1));
ridgeCoord = detectRidges(img, scaleRange, scaleSteps, roiThresh(2));

% Concatenate the list of extrema and ridges
regionCoord = [extremCoord; ridgeCoord];


% Delete regions that are too close to the image boundary
delInd = identifyEdgeRegions(size(img), regionCoord);
regionCoord(delInd,:) = [];

% Display the regions detected, superimposed on the original image
figure,
plotDetectedRegions(img, regionCoord);

end