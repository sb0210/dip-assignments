function [ rmsd ] = RMSD( img1, img2 )
%RMSD Summary of this function goes here
%   Detailed explanation goes here
    dif = img1-img2;
   rmsd = sum(sum(dif.^2));
   [numRows, numCols] = size(dif);
   rmsd = rmsd/(numRows*numCols);
   rmsd = sqrt(rmsd);
   
end

