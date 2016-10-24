%% MyMainScript

tic;
%% Your code here

I = load('../data/boat.mat');
img = I.imageOrig;
intensityRange = max(max(img)) - min(min(img));
img = (img-min(min(img)))/intensityRange;
sig1 = 0.7;
sig2 = 1;
k = 0.02;
myHarrisCornerDetector(img,sig1,sig2,k);
% toc;
