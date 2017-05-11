function [model]=gmmMStep(model, features, weights, compProb)
[Nc,Nx]=size(compProb);
Nw=sum(weights);
for j=1:Nc
    Nj=0;
    model.mean(j,:)=[0 0 0];
    tmp=zeros(3,3);
    for i=1:Nx
        Nj=Nj+weights(i)*compProb(j,i);
    end
    model.weight(j)=Nj/Nw;
    
    for i=1:Nx
        model.mean(j,:)=model.mean(j,:)+weights(i)*features(i,:)*compProb(j,i);
    end
    model.mean(j,:)=model.mean(j,:)/Nj;
    
    for i=1:Nx
        tmp=tmp+weights(i)*((features(i,:)-model.mean(j,:))'*(features(i,:)-model.mean(j,:))*compProb(j,i));
    end
    model.covar(j,:,:)=tmp/Nj;
end