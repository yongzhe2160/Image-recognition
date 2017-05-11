function [G] = normalizeFD(F)
G = F;
G(1)=0;
G = abs(G);
G =  G/(abs(G(2)));
G = abs(G);

end 