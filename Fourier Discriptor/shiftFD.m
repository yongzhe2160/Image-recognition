function [G] = shiftFD(F,x,y)
% shifts the complex curve 
% note that the 0 th coordinate of the fouriertransform is the shift
[m n] = size(F);
G=F;
G(1) = G(1) +n*complex(x,y);
end 