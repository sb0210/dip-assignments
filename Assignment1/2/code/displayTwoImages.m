function displayTwoImages(I,I2,name)
    myNumOfColors = 200;
    myColorScale = [[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]'];
    figure('name',name);
    colormap(myColorScale);
    subplot(2,1,1),subimage(I);
    colorbar;
    subplot(2,1,2),subimage(I2);
    colorbar;
    daspect([1 1 1]);
    axis tight;
    colorbar;
    saveas(gcf,strcat('../images/',name,'.png'))    
end
