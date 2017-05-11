function [model]=learnGaussMixModel(features, weights, componentNum)

model.weight = 1;
model.mean = zeros(1,3);
model.covar = zeros(1,3,3);
model.covar(1,:,:)= eye(3);

for c=1:componentNum
    lastPX = -Inf;
    logP = calcLnTotalProb(model,features,weights);
    
    while(logP -lastPX > eps)
        lastPX =  calcLnTotalProb(model,features,weights);
        compProb = gmmEStep(model,features);
        model = gmmMStep(model,features,weights,compProb);
    end
    model = initNewComponent(model, features, weights); 
end
