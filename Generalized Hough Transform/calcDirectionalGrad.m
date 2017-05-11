% calcDirectionalGrad
%
% img:              Gray scale image
% gradKernelSize:   Filter size (not necessarily integer)
% grad:             Complex Gradients
%
% Computes the gradients of img in x and y directions.
% real(grad): Gradient in x direction
% imag(grad): Gradient in y direction
%

function [grad]=calcDirectionalGrad(img, gradKernelSize)
imgSize = size(img);
img = fft2(img);

imgCenter = floor(0.5*imgSize);
xMat = ones(imgSize(1),1) * (0:imgSize(2)-1) - imgCenter(2);
yMat = (0:imgSize(1)-1)' * ones(1,imgSize(2)) - imgCenter(1);

% Gauss function with standard deviation sqrt(2)*gradKernelSize
gauss = (xMat.^2 + yMat.^2)/(gradKernelSize^2);
gauss = exp(-gauss);

% Convolution in the frequency domain
dirGauss = gauss .* (-xMat/gradKernelSize^2);
dirGauss = fft2(circshift(dirGauss,-imgCenter));
grad = ifft2(img.*dirGauss);

dirGauss = gauss .* (-yMat/gradKernelSize^2);
dirGauss = fft2(circshift(dirGauss,-imgCenter));

% Compose the complex gradient
grad = grad + i*ifft2(img.*dirGauss);

end