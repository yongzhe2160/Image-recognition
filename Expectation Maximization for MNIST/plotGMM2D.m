function plotGMM2D(model,features)

componentNum = numel(model.weight);
featureNum = size(features,1);
samplePoints = 100;
dispStretch = 1.5;

crd = zeros(2,samplePoints,samplePoints);
plotRange = zeros(2);
for i=1:2
    crdRange = dispStretch * [min(features(:,i)),max(features(:,i))] ...
        + (1-dispStretch) * mean(features(:,i));
    
    crdStep = (crdRange(2)-crdRange(1))/(samplePoints-1);
    crd(i,:,:) = ones(samplePoints,1) * (crdStep*[1:samplePoints]) + crdRange(1);
    plotRange(:,i) = crdRange;
end
crd(2,:,:) = squeeze(crd(2,:,:))';

crdFeatures = zeros(samplePoints^2,2);
for i=1:2
    crdFeatures(:,i) = reshape(crd(i,:,:),[samplePoints^2,1]);
end

dataProb = sum(exp(calcLnDataProb(model,crdFeatures)),1);

dataProb = reshape(dataProb, [samplePoints, samplePoints]);

close('all');

figure;
surf(dataProb);

figure;
plot(features(:,1),features(:,2),'gx');
xlim(plotRange(:,1));
ylim(plotRange(:,2));

end