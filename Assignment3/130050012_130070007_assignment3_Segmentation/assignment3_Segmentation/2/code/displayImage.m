function displayImage(I,name)
    figure('name',name);
    imshow(I);
    colorbar,;
    axis tight;
    saveas(gcf,strcat('../images/',name,'.png'))    
end
