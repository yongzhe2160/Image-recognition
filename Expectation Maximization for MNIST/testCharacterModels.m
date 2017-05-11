% function testCharacterModels
% 
% Main program for evaluating the trained models using unseen digits
% Loop over all digits in param.digits (see initGMMParam.m)
% Images to classify in 'mat/images/test/[0123456789]'
    
    
function testCharacterModels

% initialise parameters
param = initGmmParam();

% for restore == 0:
%   all features are extracted again
% for restore == 1:
%   load previously extracted features

restore = 0;

if (restore)
    disp('TRAIN: Restoring previously computed features');
    load([param.restorePath,'testFeatures.mat']);
    load([param.restorePath,'testWeights.mat']);
    load([param.restorePath,'testImgOffset.mat']);
else
    disp('TRAIN: Not restoring previously computed features');

    % Extract features for each image and each digit
    [features,weights,imgOffset] = buildFeatureSpace('test', param);

    % save extracted features
    save([param.restorePath,'testFeatures.mat'], 'features');
    save([param.restorePath,'testWeights.mat'], 'weights');
    save([param.restorePath,'testImgOffset.mat'], 'imgOffset');
end

% load trained digit models (siehe trainCharacterModels)
load([param.restorePath,'characterModels.mat']);

% classify all images associated with digits param.digits...
confusionMatrix = zeros(10);
for i=(param.digits+1)
    fprintf(['Testing model for character "',num2str(i-1),'"... ']);

    % for all images of the current digit
    for j=1:param.imgNum
        % isolate features from the current image
        imgInd = imgOffset{i}(j)+1:imgOffset{i}(j+1);        
        imgFeatures = features{i}(imgInd,:);
        imgWeights = weights{i}(imgInd);
        
        % classify the image using the extracted features
        objClass = classifyImage(models,param.digits,imgFeatures,imgWeights);
        
        % the confusion matrix contrasts the real class with the
        % classification results. High values on the diagonal indicate
        % accurate classification (reality and classification coincide)
        
        confusionMatrix(i,objClass+1) = confusionMatrix(i,objClass+1)+1;
    end
    disp([num2str(round(100.0*confusionMatrix(i,i)/param.imgNum)),'% correct.']);
end

% display the results of classification

overall = sum(diag(confusionMatrix))/(numel(param.digits)*param.imgNum);
disp(['Overall performance: ', num2str(100.0*overall), '%']);

close('all');
image(100.0*confusionMatrix/param.imgNum, 'CDataMapping', 'scaled');
xlabel('Result of Classifier');
ylabel('Reality');
title('Confusion Matrix');
colormap('jet');
colorbar;

end
