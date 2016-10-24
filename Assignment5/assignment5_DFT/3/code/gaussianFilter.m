function [ filter ] = gaussianFilter( size, sigma )

[x,y] = meshgrid(1:size);
mid_x = double(size)/2;
mid_y = double(size)/2;

filter = exp(-((x-mid_x).^2 + (y-mid_y).^2)/(2*sigma*sigma));



end

