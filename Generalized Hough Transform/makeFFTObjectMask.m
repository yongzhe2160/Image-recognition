function [fftMask]=makeFFTObjectMask(template,scale,angle,imgSize)
Mask=zeros(imgSize);
OB=template(:,:,1);
OI=template(:,:,2);

% scale
%OBscaled=imresize(OB, scale, 'bicubic');
OIscaled=imresize(OI, scale, 'bicubic');

% rotation
%OBrotated=imrotate(OBscaled, angle/pi*180, 'bicubic', 'loose');
OIrotated=imrotate(OIscaled, angle/pi*180, 'bicubic', 'loose');
OIrotated=OIrotated*exp(i*angle);


[row col]=size(OIrotated);

% generate OB
OBrotated=zeros(row,col);
OBrotated(:)=abs(OIrotated)>max(max(abs(OIrotated)))*0.5;

% OI*OB
Mask(1:row,1:col)=OIrotated.*OBrotated;

% normalizing
Mask=Mask/sum(abs(Mask(:)));

% centring
Mask=circshift(Mask,[-round(row/2),-round(col/2)]);

% fourier transform
fftMask=(fft2(Mask));