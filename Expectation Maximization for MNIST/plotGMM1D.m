function plotGMM1D(model, weights)

featureNum = numel(weights);
componentNum = numel(model.weight);
subSamp = 10;

hold on;
bar(weights/sum(weights))

x = (1:subSamp*featureNum)/subSamp;
totalGauss = zeros(1,subSamp*featureNum);
for i=1:componentNum
    var = model.covar(i);
    mu = model.mean(i);
    
    gauss = exp(-0.5*(x-mu).^2/var);
    gauss = model.weight(i)*subSamp*gauss/sum(gauss);
    plot(x,gauss,'g','LineWidth',3);
    
    totalGauss = totalGauss + gauss;
end

plot(x,totalGauss,'--r','LineWidth',3);
xlim([1,featureNum]);
hold off;

end