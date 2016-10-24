function myBilinearInterpolation(I,name)
    myNumOfColors = 200;
    myColorScale = [[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]'];
    I1 = zeros(size(I)*[2 0;0 3] - [1 2]);
    I1(1:2:end,1:3:end) = double(I)/256;
    I1(1:2:end,2:3:end) = (2*I1(1:2:end,1:3:end-3) + I1(1:2:end,4:3:end))/3;
    I1(1:2:end,3:3:end) = (I1(1:2:end,1:3:end-3) + I1(1:2:end,4:3:end)*2)/3;
    I1(2:2:end,1:3:end) = (I1(1:2:end-2,1:3:end) + I1(3:2:end,1:3:end))/2;
    I1(2:2:end,2:3:end) = (I1(2:2:end,1:3:end-3)*2 + I1(2:2:end,4:3:end))/3;
    I1(2:2:end,3:3:end) = (I1(2:2:end,1:3:end-3) + I1(2:2:end,4:3:end)*2)/3;
    displayImage(I,'Original Barbara');
    displayImage(I1,'Bilinear Interpolated Barbara');
end    