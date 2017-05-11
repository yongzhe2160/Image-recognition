% function [param]=initGmmParam()
% 
% param: Structure with parameters for the training/classification process
%
% Defines a structure with parameters to be used during training and classification
%
% param.restorePath: Path to a directory used to save intermediate results
% param.digits: List of digits to process (e.g. [0,1,5] would indicate that only digits ?0?, ?1?, and ?5? are to be processed)
% param.imgNum: The number of images to use for each digit (applies to training and classification)
% param.extremThresh: The threshold used during extrema detection (see detectExtrema.m)
% param.scaleRange: The range of scales for extrema detection (see detectExtrema.m)
% param.scaleSteps: The resolution in scale for extrema detection (see detectExtrema.m)
% param.componentNum:	The number of components in the mixture model of each digit


function [param]=initGmmParam()

param.restorePath = './images/';

param.digits = [0:2];
param.imgNum = 60;
param.extremThresh = 0.01;
param.scaleRange = [1.5, 25];
param.scaleSteps = 10;
param.diffKernSize = 1.5;
param.componentNum = 5;

end
