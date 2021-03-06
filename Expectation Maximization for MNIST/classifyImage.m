function [objClass]=classifyImage(models, digits, features, weights)
lnTotalProb=zeros(length(digits),1);

for j=(digits+1)
    models{j}.weight=real(models{j}.weight);
    models{j}.mean=real(models{j}.mean);
    models{j}.covar=real(models{j}.covar);
    lnTotalProb(j,1)=calcLnTotalProb(models{j},features,weights);
end
a=real(lnTotalProb(:,1))/10000;
[c i]=max(a);
objClass=i-1;