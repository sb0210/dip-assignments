%% MyMainScript

tic;
%% Your code here
img = load('../data/barbara.mat')
img = img.imageOrig;

intensityRange = max(max(img)) - min(min(img));
noise = 0.05 * intensityRange * randn(size(img));
noisyImg = img + noise;


toc;
