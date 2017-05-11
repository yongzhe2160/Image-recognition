function [compProb]=gmmEStep(model, features)
lnFeatureProb=calcLnFeatureProb(model, features);
Nc=length(model.weight);
Nx=size(features,1);
compProb=zeros(Nc,Nx);
for i=1: Nx
    lnc=max(lnFeatureProb(:,i));
    B=sum(exp(lnFeatureProb(:,i)-lnc));
    lnt=log(B)+lnc;
    compProb(:,i)=exp(lnFeatureProb(:,i)-lnt);
end

