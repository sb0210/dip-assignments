function myCLAHE(I, name, windowSize, threshold)
    margin = (windowSize-1)/2;
    I2 = zeros(size(I));
    [numRows, numColumns, numChannels ] = size(I);
    for x = 1:numRows
        for y = 1:numColumns
            for c = 1:numChannels
                l = max(1,x-margin);
                r = min(numRows,x+margin);
                t = max(1,y-margin);
                b = min(numColumns,y+margin);
                window = I(l:r,t:b,c);
                myHistogram = histcounts(window,0:255)/(numRows*numColumns);
                
                truncatedHistogram = min(myHistogram,threshold);
                differenceHistogram = myHistogram - truncatedHistogram;
                summ = sum(differenceHistogram);
                myHistogram = truncatedHistogram + summ/256;
                myCDF = cumsum(myHistogram);
                myCDF = double(myCDF)/max(myCDF);
                I2(x,y,c) = myCDF(window(x-l+1,y-t+1)+1);
            end
        end
    end
    displayTwoImages(I,I2,strcat(name,' CLAHE'));
end    