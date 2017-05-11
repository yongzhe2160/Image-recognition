function [] = plotFD(F)
% the fourier descriptor is given 
A=ifft(F);
% A is given through a number of coordinates through the inverser fourier
% transform
plot(A);
end 