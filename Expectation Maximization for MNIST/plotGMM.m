% function plotGMM(model, features)
% 
% model: Parameters of a Gaussian mixture model (see learnGaussMixModel.m)
% features: The feature vectors used to train the model
%
% Visualises the contents of a feature space and the associated mixture model
% Feature vectors are plotted as green points
% The means of components are indicated by red circles
% The eigenvectors of the covariance are indicated by blue lines
    
function plotGMM(model, features)

% number of components in the model
compNum = numel(model.weight);

hold on;
% plot feature vectors
plot3(features(:,1),features(:,2),features(:,3), 'g.','MarkerSize',7);

% display individual components...
for i=1:compNum
    % eigenvector/eigenvalue decomposition
    [eVec,eVal] = eig(squeeze(model.covar(i,:,:)));
    
    % plot the mean value
    mean = squeeze(model.mean(i,:));
    plot3(mean(1),mean(2),mean(3),'ro');
    
    % plot the standard deviation along the eigenvectors as lines
    for i=1:3
        devVec = (sqrt(eVal(i,i)) * eVec(:,i))*[-1,1];
        plot3(mean(1)+devVec(1,:),mean(2)+devVec(2,:),mean(3)+devVec(3,:),'b');
    end
end

% rotate the 3d view and add a title
hold off;
view([19,25]);
grid('on');
title(['Gaussian Mixture Model (',num2str(compNum),' components)']);

end