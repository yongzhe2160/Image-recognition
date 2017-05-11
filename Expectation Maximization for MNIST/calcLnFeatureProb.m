function [lnFeatureProb]=calcLnFeatureProb(model, features)
Nc=length(model.weight);
Nx=size(features,1);
lnFeatureProb=zeros(Nc,Nx);
for j=1:Nc
    for i=1:Nx
        lnFeatureProb(j,i)=log(model.weight(j))-.5*(log(det(squeeze(model.covar(j,:,:))))+((features(i,:)'-model.mean(j,:)')'*inv(squeeze(model.covar(j,:,:)))*(features(i,:)'-model.mean(j,:)')));
    end
end
