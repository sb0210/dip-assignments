%% MyMainScript

tic;
%% Your code here
im = imread('../data/barbara256-part.png');
sigma = 20;
sigma2 = 400;
K = 200;
im1 = double(im) + randn(size(im))*20;
image1 = myPCADenoising1(im1,sigma2);
image2 = myPCADenoising2(im1,sigma2);
image3 = myBilateralFiltering(im1, 20,20);
displayImage(im,'Original Image');
displayImage(im1,'Noisy Image');
displayImage(image1,'myPCADenoising1 Image');
displayImage(image2,'myPCADenoising2 Image');
displayImage(image3,'Bilateral Filtering Image');

disp(['RMSD of Original Image and Noisy Image = ', num2str(RMSD(double(im),im1))]);
disp(['RMSD of Original Image and myPCADenoising1 = ', num2str(RMSD(double(im),image1))]);
disp(['RMSD of Original Image and myPCADenoising2 = ', num2str(RMSD(double(im),image2))]);
disp(['RMSD of Original Image and Bilateral Filtering = ', num2str(RMSD(double(im),image3))]);


toc;
