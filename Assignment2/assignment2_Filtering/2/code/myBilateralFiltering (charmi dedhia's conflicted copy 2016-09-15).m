function [ outImg ]= myBilateralFiltering(Img,sigSpace,sigIntensity)
%MYBILATERALFILTERING Summary of this function goes here
%   Detailed ex planation goes here
    w = 5;
    [numRows, numCols] = size(Img);
    outImg = zeros(numRows, numCols);
    spaceGaussian = fspecial('gaussian', 2*w+1, sigSpace);
    
    for i=1:numRows
        for j=1:numCols
           
            l = max(1,i-w);
            r = min(numRows,i+w);
            t = max(1,j-w);
            b = min(numCols,j+w);
            window = Img(l:r,t:b);
            intensityGaussian = exp(-(window-Img(i,j)).^2/(2*sigIntensity^2));
            filter = intensityGaussian.* spaceGaussian(l-i+w+1:r-i+w+1, t-j+w+1: b-j+w+1);
            outImg(i,j)= sum(window(:).*filter(:))/sum(filter(:));
            
        end
    end
end

