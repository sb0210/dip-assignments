function [ out ] = subSample( img )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[ numRows, numCols] = size(img);
blurmask = fspecial('gaussian',11,0.66);
img2 = imfilter(img,blurmask,'conv');
out = img2(1:2:numRows,1:2:numCols);
end

