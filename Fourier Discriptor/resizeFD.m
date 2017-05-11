function [G] = resizeFD(F,n)
[a,b] = size(F);

% the effective frequencies lie in the end  
% we use fftshift to transform them to the middle 
A = fftshift(F);
% we cut off the components of uneffective high frequencies 
% because we already did fftshift , this has to be done 
% around the center of the interval

beginning = floor(a/2 -n/2);
G = zeros(1,n);
if beginning>0


    for j = 1 : n
        G(j) = A(j+beginning);   
    end 
else
    beginning=-beginning;
    for j= 1 : a
        G(j+beginning)=A(j);
    end
end 