function [template]=makeMarkerTemplate(templateEdgeLen)
% allocating template, OB
template=zeros(templateEdgeLen,11,2);

% create OB
OB=zeros(11,11);
OB(:,6)=ones(11,1);


% create the complex gradient OI
OI=zeros(11,11);
OI(:,6)=[ones(floor(templateEdgeLen/2),1); 0; -ones(templateEdgeLen-floor(templateEdgeLen/2)-1,1)];

% give value to template
template(:,:,1)=OB;
template(:,:,2)=OI;
