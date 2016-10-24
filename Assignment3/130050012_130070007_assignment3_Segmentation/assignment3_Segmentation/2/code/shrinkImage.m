function [ newImage ] = shrinkImage( img )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [numRows, numCols] = size(img);
    newImage = zeros(numRows/2,numCols/2,3);
    newImage = img(1:2:end,1:2:end,:);

end

