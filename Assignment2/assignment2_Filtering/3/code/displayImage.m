function displayImage(I,name)
    myNumOfColors = 200;
    myColorScale = [[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]'];
    figure('name',name);
    imagesc(I);
    colormap(myColorScale);
    colorbar,;
    daspect([1 1 1]);
    axis tight;
    colorbar;
    saveas(gcf,strcat('../images/',name,'.png'))    
end
