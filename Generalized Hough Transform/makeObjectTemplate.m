function [template] = makeObjectTemplate(templateImg, gradKernelSize, templateThresh)
[row col]=size(templateImg);

% allocating template, OB
template=zeros(row,col,2);
OB=zeros(row, col);

% create the complex gradient OI by "calcDirectionalGrad"
OI=calcDirectionalGrad(templateImg, gradKernelSize);

% give value to OB
OB(:)=abs(OI)>max(max(abs(OI)))*templateThresh;

% give value to template
template(:,:,1)=OB;
template(:,:,2)=OI;
