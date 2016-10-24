function [ filter ] = idealLowFilter( size, frequency)

[x,y] = meshgrid(1:size);
mid_x = double(size)/2;
mid_y = double(size)/2;

filter = (x-mid_x).^2 + (y-mid_y).^2 < frequency^2;

end

