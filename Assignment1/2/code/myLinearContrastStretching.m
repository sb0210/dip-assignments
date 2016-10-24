function myLinearContrastStretching(I,name)
    I = double(I)/256;
    minIntensity = min(min(I));
    minIntensity(:,:,:) = 0.1;
    maxIntensity = max(max(I));
    I2 = zeros(size(I));
    [~,~,channels] = size(I);
    for c = 1:channels
        I2(:,:,c) = (I(:,:,c)-minIntensity(:,:,c))/(maxIntensity(:,:,c)-minIntensity(:,:,c));
    end    
    displayTwoImages(I,I2,strcat(name,' Linear Contrast Stretching'));
end