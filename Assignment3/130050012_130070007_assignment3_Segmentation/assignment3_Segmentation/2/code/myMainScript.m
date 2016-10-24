%% MyMainScript

tic;
%% Your code here
img = imread('../data/baboonColor.png');
img = double(img);
sigSpace = 18;
sigIntensity = 23 ;
numIterations = 20;
alpha = 1;
finalImage = myMeanShiftSegmentation(img,sigSpace, sigIntensity, numIterations, alpha);
toc;