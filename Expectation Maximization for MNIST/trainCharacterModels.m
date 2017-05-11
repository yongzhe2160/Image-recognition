% function trainCharacterModels
% 
% Main program for learning mixture models for digits
% Loop over all digits in param.digits (see initGMMParam.m)
% Training images in 'mat/images/train/[0123456789]'
    
    
function trainCharacterModels

% initialise parameters
param = initGmmParam();

% for restore == 0:
%   all features are extracted again
% for restore == 1:
%   load previously extracted features

restore = 0;

if (restore)
    disp('TRAIN: Restoring previously computed features');
    load([param.restorePath,'trainFeatures.mat']);
    load([param.restorePath,'trainWeights.mat']);
else
    disp('TRAIN: Not restoring previously computed features');

    % Extract features for each image and each digit
    [features,weights] = buildFeatureSpace('train', param);

    % save extracted features
    save([param.restorePath,'trainFeatures.mat'], 'features');
    save([param.restorePath,'trainWeights.mat'], 'weights');
end

% for all digits in param.digits
models = cell(10,1);
for i=(param.digits+1)
    disp(['TRAIN: Learning model for character "',num2str(i-1),'"...']);

    % use expectation maximisation to train a gaussian mixture model for
    % the features of the current digit
    models{i} = learnGaussMixModel(features{i}, weights{i}, param.componentNum);

end

% save the learned models in param.restorePath
save([param.restorePath,'characterModels.mat'], 'models');

figure,plotGMM(models{1}, features{1});