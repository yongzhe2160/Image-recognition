% function [features,weights]=buildFeatureSpace(dataSet, param)
% 
% 
% dataSet: The set of images to extract features from (String, 'train' or 'test')
% param: Parameters for the training process (see initGMMParam.m)
% features: Feature space [X] containing features from all processed images
% features{n}: Features associated with digit (n-1)
% features{n}(j,:): Feature vector j for digit (n-1)
% weights: Weights w of the extracted features (one weight per feature)
% weights{n}: Weights  w of all features for digit (n-1)
%
% Extracts feature vectors and weights of images for training or evaluation
% Only digits in the list param.digits are processed.
%   - E.g. if param.digits=[4], only features(5,:,:) and weights(5,:,:) are computed.
% Uses the detectExtrema.m function of exercise 3

function [features,weights,imgOffset]=buildFeatureSpace(dataSet, param)

% cell arrays for features and weights. One cell per digit
features = cell(10,1);
weights = cell(10,1);
imgOffset = cell(10,1);

scaleIncr = (param.scaleRange(2)-param.scaleRange(1))^(1.0/(param.scaleSteps-1));

% start timer
tic;

% for all digits in param.digits...
for i=param.digits

    % directory with images of the current digit
    imgDir = ['./images/',dataSet,'/', num2str(i), '/'];
        
    fprintf('FEATURE: Extracting features for digit "%i": ',i);

    % for all images (that are to be used) of the current digit
    for j=1:param.imgNum
        
        % load the image
        img = double(imread([imgDir,num2str(j),'.png']));
        
        % detect scale space extrema
        [extremCrd,extremWeight] = ...
            detectExtrema(img, param.scaleRange, param.scaleSteps, param.extremThresh);
        extremNum = size(extremCrd,1);
        
        % add synthetic uncertainty to the scale coordinate (compensate for
        % poor resolution)
        errRange = extremCrd(:,3)*scaleIncr.^([-1,1]);
        errWeight = rand(extremNum,1);
        extremCrd(:,3) = extremCrd(:,3) + errWeight.*errRange(:,1) + (1-errWeight).*errRange(:,2);
        
        % remember which features come from which image
        imgOffset{i+1}(j) = size(features{i+1},1);

        % extrema coordinates act as feature vectors
        % weights are taken from the Hessian determinant at detection
        features{i+1} = [features{i+1}; extremCrd(:,1:3)];
        weights{i+1} = [weights{i+1}; extremWeight];
                
        % produce graphical output every three seconds
        if (toc > 3.0)
            subplot(1,2,1);
            plot3(features{i+1}(:,1), features{i+1}(:,2), features{i+1}(:,3), 'gx');
            grid('on');
            title(['Feature Space "',num2str(i),...
                '" (',num2str(j),' images)']);
            axis tight

            subplot(1,2,2);
            plotDetectedRegions(img, extremCrd);
            title(['Example image of "', num2str(i), '"']);
            drawnow;
    
            fprintf('...%i%%', round(100.0*j/param.imgNum));
            tic;
        end
        
    end
    
    imgOffset{i+1}(param.imgNum+1) = size(features{i+1},1);
    
    fprintf('\n');
end

end
