function [ridgeCoord, ridgeWeight]=detectRidges(img, scaleRange, scaleSteps, ridgeThresh)

[row col]=size(img);
det=zeros(row, col, scaleSteps);
tr=zeros(row, col, scaleSteps);
B11=zeros(row, col, scaleSteps);
B12=zeros(row, col, scaleSteps);
B22=zeros(row, col, scaleSteps);
R=zeros(row, col, scaleSteps);

[distMat, diffX, diffY]=calcDiffMatrices(size(img));
imgF=fft2(img);
tao=(scaleRange(2)/scaleRange(1))^(1/(scaleSteps-1));

for i=1:scaleSteps
    t=tao^(i-1)*scaleRange(1);
    G=1/(pi*t)*exp(-distMat/t);

    Ux=ifft2(sqrt(t).*diffX.*imgF.*fft2(G).*(1-fft2(G)));
    Uy=ifft2(sqrt(t).*diffY.*imgF.*fft2(G).*(1-fft2(G)));

    B11(:,:,i)=ifft2(fft2(G).*fft2(Ux.*Ux));
    B12(:,:,i)=ifft2(fft2(G).*fft2(Ux.*Uy));
    B22(:,:,i)=ifft2(fft2(G).*fft2(Uy.*Uy));
    det(:,:,i)=B11(:,:,i).*B22(:,:,i)-B12(:,:,i).*B12(:,:,i);
    tr(:,:,i)=B11(:,:,i)+B22(:,:,i);
    R(:,:,i)=tr(:,:,i).*tr(:,:,i)-4*det(:,:,i);
end

[a b c]= size(R);
result_R = zeros(a,b);

for i = 1 : a 
   for j = 1 : b 
       result_R(i,j)= max(R(i,j,:));
   end 
end
figure,imshow(abs(result_R),[]);

[maxInd, ridgeWeight]=findLocalMaxima(R,ridgeThresh);
figure,
imshow(img);
hold on
plot(maxInd(:,2),maxInd(:,1),'*b');
hold off
[length, ignore]=size(maxInd);

for i=1: length
    a=maxInd(i,:);
    B=real([B11(a(1),a(2),a(3)) B12(a(1),a(2),a(3)); B12(a(1),a(2),a(3)) B22(a(1),a(2),a(3))]);
    
    [V D]=eig(B);
    [C I]=min(diag(D));
    W(i)=sqrt(tao^(maxInd(i,3)-1)*scaleRange(1));

    if I==1
        Vx=V(1,1);
        Vy=V(2,1);
        L(i)=W(i)*sqrt(D(2,2)/D(1,1));
    else
        Vx=V(1,2);
        Vy=V(2,2);
        L(i)=W(i)*sqrt(D(1,1)/D(2,2));
    end
    O(i)=atan2(Vy,Vx);
end

ridgeCoord(:,1)=maxInd(:,2);
ridgeCoord(:,2)=maxInd(:,1);
ridgeCoord(:,3)=W(:);
ridgeCoord(:,4)=L(:);
ridgeCoord(:,5)=O(:)
