function result=logtrickLTP(model, features, j)

Nc=length(model.weight);
expression2=zeros(Nc,1);
for i=1:Nc
    expression2(i,1)=log(model.weight(i))-0.5*log(det(squeeze(model.covar(i,:,:))))-1.5*log(2*pi)-0.5*(features(j,:)-model.mean(i,:))*inv(squeeze(model.covar(i,:,:)))*(features(j,:)-model.mean(i,:))';
end
lnc=max(expression2);
result=lnc+log(sum(exp(expression2-lnc)));
