%% MyMainScript

tic;
%% Your code
I = imread('../data/circles_concentric.png');
myShrinkImageByFactorD(I,1,'Circles Original');
myShrinkImageByFactorD(I,2,'Circles Shrink by factor 2');
myShrinkImageByFactorD(I,3,'Circles Shrink by factor 3' );
I = imread('../data/barbaraSmall.png');
myBilinearInterpolation(I,'Barbara Bilinear');
myNearestNeighborInterpolation(I,'Barbara Nearest Neighbor');
toc;

