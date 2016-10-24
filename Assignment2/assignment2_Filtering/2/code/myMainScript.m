%% MyMainScript

tic;
%% Your code here

I = load('../data/barbara.mat');
img = I.imageOrig/100;
intensityRange = max(max(img)) - min(min(img));
noise = 0.05 * intensityRange * randn(size(img));
noisyImg = img + noise;
sigmaSpace = 1.4;
sigmaIntensity = 0.102;
filteredImg = myBilateralFiltering(noisyImg,sigmaSpace,sigmaIntensity);
displayThreeImages(img, noisyImg, filteredImg,'bilateral');


% toc;
