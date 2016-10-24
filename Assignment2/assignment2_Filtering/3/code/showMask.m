function [] = showMask( )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

gauss_mask = fspecial('gaussian',[9,9],1.25);
displayImage(gauss_mask,'isotropic Mask');


end

