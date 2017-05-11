
img1=imread('leaf_type1.jpg');
img2=imread('leaf_type2.jpg');
FD1=trainingFD(img1);
FD2=trainingFD(img2);

img=imread('leaves_example.jpg');
level = graythresh(img);
BW = 1-im2bw(img,level);

SE = strel('square',3);
SE1 = strel('disk',1);
SE2 = strel('disk',11);


BW = imerode(BW,SE2);
BW = imdilate(BW,SE1);
figure,imshow(BW),title('Get rid of branches and other objects');

BW2 = imerode(BW,SE);
Contourimg = BW-BW2;
figure, imshow(Contourimg),title('The Contour of everything');

[L, num] = bwlabel(Contourimg);

[x,y]=size(L);
result=zeros(x,y,3);

for j=1:num
leaf=zeros(x,y);
[r,c] = find(L==j);
for i=1:size(r)
    leaf(r(i),c(i))=1;
end



for row = 1:x
   for col = 1:y
      if leaf(row,col),
         break;
      end
   end
   if leaf(row,col),
      break;
   end
end

contour = bwtraceboundary(leaf, [row, col], 'E');
U = complex(contour(:,1),contour(:,2));

FD3 = extractFD(U);
FD4 = normalizeFD(FD3);
FD5 = resizeFD(FD4,32);

diff1=compareFD(FD5,FD1);
diff2=compareFD(FD5,FD2);

if diff1<diff2 
    for i=1:size(r)
        result(r(i),c(i),1)=1;
    end
else
    for i=1:size(r)
        result(r(i),c(i),2)=1;
    end
end
end

result(:,:,1)=imfill(result(:,:,1),'holes');
result(:,:,2)=imfill(result(:,:,2),'holes');

figure,imshow(result),title('Result');