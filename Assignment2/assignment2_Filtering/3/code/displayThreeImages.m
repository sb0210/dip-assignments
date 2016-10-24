function displayThreeImages(I,I2,I3,name)
    myNumOfColors = 200;
    myColorScale = [[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]'];
    figure('name',name);
    colormap(myColorScale);
    subplot(1,3,1),imshow(I,[]);
    colorbar;
    subplot(1,3,2),imshow(I2,[]);
    colorbar;
    subplot(1,3,3),imshow(I3,[]);
    colorbar;
    daspect([1 1 1]);
    axis tight;
    colorbar;
    saveas(gcf,strcat('../images/',name,'.png'))    
end
