function displayImage(I,name)
    figure('name',name);
    imshow(I,[]);
    colorbar,;
    saveas(gcf,strcat('../images/',name,'.png'))    
end
