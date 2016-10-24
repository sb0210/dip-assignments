%% MyMainScript

tic;
%% Your code here

I = load('../data/barbara.mat');
img = I.imageOrig/255;
intensityRange = max(max(img)) - min(min(img));
noise = 0.05 * intensityRange * randn(size(img));
noisyImg = img + noise;
filteredImg = myBilateralFiltering(noisyImg,1.4,0.04);
figure;
imshow(img);
figure;
imshow(noisyImg);
figure;
imshow(filteredImg);

for sigspace = 1.4:0.02:1.5
     for sigIntensity = 0.035:0.002:0.045
         filteredImg = myBilateralFiltering(noisyImg,sigspace, sigIntensity);
         disp([sigspace, sigIntensity ,RMSD(img, filteredImg)])
     end
 end

% toc;
% filteredImg = myBilateralFiltering(noisyImg,sigspace, sigIntensity);