function [ newImage ] = myPatchBasedFiltering(img, sigma)

w = 12;
p = 4;
[numRows, numCols] = size(img);
newImage = zeros(size(img));
paddedImage = padarray(img, [p p]);
gauss_mask = fspecial('gaussian',[9,9],1.25);
for i = 1:numRows
    for j = 1:numCols
        l = max(1,i-w);
        r = min(numRows,i+w);
        t = max(1,j-w);
        b = min(numCols,j+w);
        currentPatch = paddedImage(i:i+2*p,j:j+2*p);
        denom = 0;
        for k = l:r
            for k2 = t:b
                patch = paddedImage(k:k+2*p,k2:k2+2*p);
                distance_square = euclidian(currentPatch, patch,gauss_mask);
                num = exp(-1*distance_square/(2*(sigma^2)));
                newImage(i,j) = newImage(i,j) + img(k,k2)*num;
                denom = denom + num;
            end
        end     
        newImage(i,j) = newImage(i,j)/denom;
    end
end