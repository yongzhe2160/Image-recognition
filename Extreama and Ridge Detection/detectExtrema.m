function [extremCoord, extremWeight]=detectExtrema(img, scaleRange, scaleSteps, extremThresh)
[row col]=size(img);
det=zeros(row, col, scaleSteps);
tr=zeros(row, col, scaleSteps);
t=zeros(scaleSteps,1);

[distMat, diffX, diffY]=calcDiffMatrices(size(img));
imgF=fft2(img);
tao=(scaleRange(2)/scaleRange(1))^(1/(scaleSteps-1));


for i=1:scaleSteps
    t(i)=tao^(i-1)*scaleRange(1);
    G=1/(pi*t(i))*exp(-distMat/t(i));
%    img1=ifft2(imgF.*fft2(G));
    H11=ifft2(imgF.*fft2(G)*t(i).*diffX.*diffX);
    H12=ifft2(imgF.*fft2(G)*t(i).*diffX.*diffY);
    H22=ifft2(imgF.*fft2(G)*t(i).*diffY.*diffY);
    det(:,:,i)=H11.*H22-H12.*H12;
    tr(:,:,i)=H11+H22;
end

[maxInd, extremWeight]=findLocalMaxima(det,extremThresh);

[length,ignore]=size(maxInd);
extremCoord(:,1)=maxInd(:,2);
extremCoord(:,2)=maxInd(:,1);
extremCoord(:,3)=sqrt(t(maxInd(:,3)));
extremCoord(:,4)=sqrt(t(maxInd(:,3)));
extremCoord(:,5)=zeros(length,1);