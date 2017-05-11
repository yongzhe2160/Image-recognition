% function testGaussMixEM
% 
% Generates random three dimensional feature vectors
% Calls the EM function to train the corresponding mixture model
    
function testGaussMixEM

% dimensionality of the generated feature vectors
vectLen = 3;

% number of components (clusters) to generate
actualComponentNum = 4;

% standard deviation of vectors in each cluster
actualDevMax = 0.3;

% number of vectors in each cluster
trainingSize = 150;


% initialise random component parameters (mean and standard deviation)
trainVect = zeros(actualComponentNum,trainingSize,vectLen);
actualMean = randn(actualComponentNum,vectLen);
actualSDev = randn(actualComponentNum,vectLen)*actualDevMax;

% initialise random cluster vectors
for i=1:actualComponentNum
    tmp = zeros(trainingSize,1)+1;
    trainVect(i,:,:) = tmp*actualMean(i,:);
    trainVect(i,:,:) = squeeze(trainVect(i,:,:)) + (tmp*actualSDev(i,:)).*randn(trainingSize,vectLen);
end
trainVect = reshape(trainVect,[actualComponentNum*trainingSize,vectLen]);
weights = ones(actualComponentNum*trainingSize,1);

% train the corresponding mixture model using EM...
model = learnGaussMixModel(trainVect,weights,actualComponentNum);
figure,plotGMM(model, trainVect);
end