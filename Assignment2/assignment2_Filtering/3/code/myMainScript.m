%% MyMainScript

tic;
%% Your code here
img = load('../data/barbara.mat')
img = img.imageOrig;

img = subSample(img);
rng(0);
intensityRange = max(max(img)) - min(min(img));
noise = 0.05*intensityRange*randn(size(img));
corruptedImage = img + noise;
sigma = 4;
    smoothedImage = myPatchBasedFiltering(corruptedImage, sigma);  
    disp([sigma, RMSD(img,smoothedImage)]);
    displayThreeImages(img,corruptedImage,smoothedImage,'patch based');
    showMask();


toc;
