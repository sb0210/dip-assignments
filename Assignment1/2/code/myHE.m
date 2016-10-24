function myHE(I, name)
    [~,~,numChannels] = size(I);
    I2 = zeros(size(I));
    for c = 1:numChannels
        myHistogram = histcounts(I,[0:255]);
        myCDF = cumsum(myHistogram);
        myCDF = double(myCDF)/max(myCDF);
        I2(:,:,c) = myCDF(I(:,:,c)+1);
    end
    displayTwoImages(I,I2,strcat(name,' Histogram Equalization'));
end    