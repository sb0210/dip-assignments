%% MyMainScript

tic;
%% Your code here
I = load('../data/lionCrop.mat');
img = I.imageOrig;
sharpenedImg = myUnsharpMasking(img, 5, 1, 2);
[numRows, numCols] = size(img);

intensityRange = max(max(img))-min(min(img));
img1 = (img - min(min(img)))*(1/intensityRange);

intensityRange1 = max(max(sharpenedImg(3:numRows-2,3:numCols-2)))-min(min(sharpenedImg(3:numRows-2,3:numCols-2)));
sharpenedImg1 = (sharpenedImg - min(min(sharpenedImg)))*(1/intensityRange1);
displayTwoImages(img1, sharpenedImg1,'lion');

I = load('../data/superMoonCrop.mat');
img = I.imageOrig;
sharpenedImg = myUnsharpMasking(img, 10, 1, 10);
[numRows, numCols] = size(img);

intensityRange1 = max(max(img))-min(min(img));
img1 = (img - min(min(img)))*(1/intensityRange1);

minimumIntensity = min(min(sharpenedImg(3:numRows-2,3:numCols-2)));
maximumIntensity = max(max(sharpenedImg(3:numRows-2,3:numCols-2)));
intensityRange2 = maximumIntensity - minimumIntensity;
sharpenedImg2 = (sharpenedImg - minimumIntensity)/intensityRange2;
displayTwoImages(img1, sharpenedImg,'superMoon');

toc;
