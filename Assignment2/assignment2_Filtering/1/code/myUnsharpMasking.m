function [ sharpenedImg ] = myUnsharpMasking( Img, hsize, sig, scalingFac )
%MY Summary of this function goes here
%   Detailed explanation goes here
    f = fspecial('gaussian', hsize, sig);
    unsharpImg = imfilter(Img, f, 'conv');
    DoG = Img - unsharpImg;
    sharpenedImg = Img + scalingFac * DoG;
end

 