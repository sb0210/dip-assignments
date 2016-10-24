function [ distance ] = euclidian( image1, image2,gauss_mask )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    distance = sum(((image1 - image2).^2).*gauss_mask);
    distance = sum(distance);
    
end

