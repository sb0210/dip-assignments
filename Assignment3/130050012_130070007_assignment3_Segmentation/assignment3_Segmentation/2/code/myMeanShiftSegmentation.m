function [ finalImage ] = myMeanShiftSegmentation( img, sigSpace, sigIntensity, numIterations, alpha )

    gaussianFilter = fspecial('gaussian',11,1);
    for i = 1:3
        img(:,:,i) = conv2(img(:,:,i),gaussianFilter,'same');
    end
    img = shrinkImage(img);
    [numRows, numCols, numChannels] = size(img);
    windowSize = 20;
    spaceGaussian = fspecial('gaussian', 2*windowSize+1, sigSpace);
    paddingSize = windowSize;
    paddedImage = padarray(img,[paddingSize, paddingSize],'symmetric');
    for iteration = 1:numIterations
        for xCoord = 1:numRows
            for yCoord = 1:numCols
                currentPatch = paddedImage(xCoord:xCoord + 2*windowSize, yCoord:yCoord + 2*windowSize,:);
                numFactor = ones(2*windowSize + 1,2*windowSize+1);
                for channel = 1:numChannels
                    newCurrentPatch = currentPatch(:,:,channel) - paddedImage(xCoord+windowSize,yCoord+windowSize,channel);
                    newCurrentPatch = (newCurrentPatch/sigIntensity).^2;
                    numFactor = numFactor.*exp(-1*newCurrentPatch);
                end
                for channel = 1:numChannels
                    numerator = (numFactor.*spaceGaussian).*currentPatch(:,:,channel);
                    numerator = sum(sum(numerator));
                    denominator = sum(sum(numFactor.*spaceGaussian));
                    meanShift = numerator/denominator - paddedImage(xCoord+windowSize,yCoord+windowSize,channel);
                    
                    i = paddedImage(xCoord + windowSize,yCoord + windowSize, channel);
                    paddedImage(xCoord + windowSize,yCoord + windowSize, channel) = i + alpha*meanShift;
                end     
            end
        end
    end     
    finalImage = paddedImage(windowSize+1:windowSize+numRows,windowSize+1:windowSize+numCols,:);

    displayImage(img/255,'Original Image');
    displayImage(finalImage/255,'Segmented Image');
end

