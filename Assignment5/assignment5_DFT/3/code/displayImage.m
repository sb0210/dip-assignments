function [ ] = displayImage( I, name )

figure;
imshow(I,[]);
title(name);
saveas(gcf,strcat('../images/',name,'.png'));

end
