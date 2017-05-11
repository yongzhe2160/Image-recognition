function [FD]=trainingFD(img)
level = graythresh(img);
BW = im2bw(img,level);

SE = strel('square',3);
BW2 = imdilate(BW,SE);

Coutourimg=BW2-BW;

s=size(Coutourimg);
for row = 1:s(1)
   for col = 1:s(2)
      if Coutourimg(row,col),
         break;
      end
   end
   if Coutourimg(row,col),
      break;
   end
end

contour = bwtraceboundary(Coutourimg, [row, col], 'E');
U = complex(contour(:,1),contour(:,2));

FD1 = extractFD(U);
FD2 = normalizeFD(FD1);
FD = resizeFD(FD2,32);
end