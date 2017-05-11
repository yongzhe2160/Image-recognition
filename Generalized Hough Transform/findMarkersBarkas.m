function [template]= findMarkers(templateEdgeLen)

templateImg = imread('./img/markers_contrast.jpg');


if (length(size(templateImg)) > 2)
    templateImg = rgb2gray(templateImg);
end
templateImg = double(templateImg);

% Compute the test image and complex gradients (scale and rotate original)
testAngle =0;
testScale =1;
scaleRange = [1,2];

testImg = makeTestImg(templateImg, testAngle, testScale, scaleRange);
gradKernelSize= 5;
gradImg = calcDirectionalGrad(testImg, gradKernelSize);

% Compute the object template
gradKernelSize = 3;
templateThresh =0.1;

template = makeObjectTemplate(templateImg, gradKernelSize, templateThresh);


% Ab hier sind die einzelenen Abschnitte nicht mehr Ident mit  
[m n]= size(template(:,:,1));
%gradImg1 = imresize(real(gradImg),[m n],'bicubic');
gradImg = imresize(gradImg,[m n],'bicubic');
gradImg = (gradImg >0) -(gradImg <0);




%%subplot(3,1,1);
%%imshow(template(:,:,1),[]);

%%subplot(3,1,2);
%%imshow(template(:,:,2),[]);

for i =1: m
   for j = 1:n
   aba = size(template(:,j,1));
   aba2 = size(gradImg);
   yinterv= max(1,(i-floor(templateEdgeLen/2))):min([(i+floor(templateEdgeLen/2)),aba(1),aba2(1)]);

 
   aba = size(template(i,:,1));
   aba2 = size(gradImg);
   xinterv = max(1,(j-floor(templateEdgeLen/2))):min([(j+floor(templateEdgeLen/2)),aba(2),aba2(2)]);
   
   
   dummyx= template(i,:,1);
   dummyxgrad =real(gradImg(i,:));
   
   dummyy =template(:,j,1); 
   dummyygrad = imag(gradImg(:,j));
   % a is the first part of the template where in the interval just ones
   % are expected
   
   
   A= dummyx(xinterv(:));
   B = dummyxgrad(xinterv(:));
   
   % B is the second part of the template where the sign flip has to occur
   control1 =sum(A(:));
   
   grad_plus_B = (B > 0);
   grad_minus_B = (B < 0);
   grad_null_B =(B==0);
  
   C = dummyy(yinterv(:));
   D = dummyygrad(yinterv(:));
   control2 = sum(C(:));
   
   grad_plus_D = (D > 0);
   grad_minus_D = (D <0);
   grad_null_D = (D==0);
   
     if control1 == templateEdgeLen
       a = sum(grad_plus_B(:));
       b = sum(grad_minus_B(:));
       c= sum(grad_null_B(:));
       if ((a >0)&&(b >0))
          markerImg(i,j)=1*template(i,j,1);
       else 
           markerImg(i,j)=0;
       end     
     end
   
     
     if control2 == templateEdgeLen
      a = sum(grad_plus_D(:));
      b = sum(grad_minus_D(:));
      c = sum(grad_null_D(:));
      
       if ((a >0)&&(b >0))
          markerImg(i,j)=1*template(i,j,1);
       else 
          markerImg(i,j)=0;
       end      
     end     
     
 end %% innere for Schleife
 
end %% aeussere for Schleife
%subplot(3,1,2);
imshow(markerImg,[]);
template = markerImg;
end 