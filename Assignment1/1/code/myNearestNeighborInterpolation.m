function myNearestNeighborInterpolation(I,name)
    I1 = zeros(size(I)*[2 0;0 3] - [1 2]);
    I1(1:2:end,1:3:end) = double(I)/256;
    I1(1:2:end,2:3:end) = I1(1:2:end,1:3:end-3);
    I1(1:2:end,3:3:end) = I1(1:2:end,4:3:end);
    I1(2:2:end,1:3:end) = I1(1:2:end-2,1:3:end);
    I1(2:2:end,2:3:end) = I1(2:2:end,1:3:end-3);
    I1(2:2:end,3:3:end) = I1(2:2:end,4:3:end);
    displayImage(I1,name);
end

