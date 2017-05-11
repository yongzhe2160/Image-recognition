function [houghSpace]=generalHough(gradImg,template,scaleSteps,scaleRange,angleSteps,angleRange)

% calculate the stepsize of the scale and angle
S=(scaleRange(2)-scaleRange(1))/(scaleSteps-1);
A=(angleRange(2)-angleRange(1))/angleSteps;

% initiating the value of scale and angle
scale=scaleRange(1);
angle=angleRange(1);

% allocating the houghSpace
[col row]=size(gradImg);
houghSpace=zeros(col,row,scaleSteps, angleSteps);

% transfer the gradImg into frequency domain
fftImg=(fft2(gradImg));

% loop of scales and angles
for s=1:scaleSteps
    for a=1:angleSteps
        fftMask=makeFFTObjectMask(template,scale,angle,size(gradImg));  %creat fftMask
        conjMask=conj(fftMask); %calculate conjugate of fftMask
        houghSpace(:,:,s,a)=abs(real(ifft2(fftImg.*conjMask)));   %calculate the corelation between the image and the mask

        angle=angle+A;
    end
    scale=scale+S;
end
