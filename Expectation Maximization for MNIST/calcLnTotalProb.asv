function [lnTotalProb]=calcLnTotalProb(model, features, weights)

Nx=size(features,1);
lnTotalProb=0;
for j=1:Nx
    lnTotalProb=lnTotalProb+weights(j)*logtrickLTP(model, features, j);
end

        
