function [distMat, diffX, diffY]=calcDiffMatrices(imgSize)
distMat=zeros(imgSize);
diffX=zeros(imgSize);
diffY=zeros(imgSize);

for x=-floor(imgSize(2)/2):floor(imgSize(2)/2)-1
    for y=-floor(imgSize(1)/2):floor(imgSize(1)/2)-1
        distMat(y+floor(imgSize(1)/2)+1,x+floor(imgSize(2)/2)+1)=x^2+y^2;
        diffX(y+floor(imgSize(1)/2)+1,x+floor(imgSize(2)/2)+1)=2*pi*i*x/imgSize(1);
        diffY(y+floor(imgSize(1)/2)+1,x+floor(imgSize(2)/2)+1)=2*pi*i*y/imgSize(2);
    end
end
distMat=circshift(distMat,[floor(imgSize(1)/2), floor(imgSize(2)/2)]);
diffX=circshift(diffX,[0,-floor(imgSize(2)/2)]);
diffY=circshift(diffY,[-floor(imgSize(1)/2),0]);
