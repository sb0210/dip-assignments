%% MyMainScript

tic;
%% Code

im = imread('../data/barbara256.png');
[~, side] = size(im);
fourierTrans = fftshift(fft2(im));
Mag = abs(fourierTrans);
Phase = angle(fourierTrans);
displayImage(im,'Original Image');
displayImage(log(Mag),'Log of Fourier Transform of Original Image');
for i = [40, 80]
    sigma = i;
    frequency = i;
    gauss = gaussianFilter(side,sigma);
    ideal_low = idealLowFilter(side, frequency);

    GaussMag = gauss.*Mag;
    IdealLowMag = ideal_low.*Mag;

    GaussFourier = GaussMag.*exp(Phase*sqrt(-1));
    IdealLowFourier = IdealLowMag.*exp(Phase*sqrt(-1));

    ResultGauss = abs(ifft2(ifftshift(GaussFourier)));
    ResultIdealLow = abs(ifft2(ifftshift(IdealLowFourier)));
    displayImage(log(GaussMag),strcat('Log of Fourier Transform after Gauss Filter. sigma = ',num2str(sigma)));
    displayImage(log(IdealLowMag),strcat('Log of Fourier Transform after Low Pass Filter. freq = ',num2str(frequency)));
    displayImage(ResultGauss,strcat('Final Image after Gauss Filter. sigma = ',num2str(sigma)));
    displayImage(ResultIdealLow,strcat('Final Image after Low Pass Filter. freq = ',num2str(frequency)));
end
toc;
