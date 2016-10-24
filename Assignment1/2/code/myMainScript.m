%% MyMainScript

tic;
%% Your code here
images = {'barbara','TEM','canyon'};
for image = images
    I = imread(strcat('../data/',image{1},'.png'));
     myLinearContrastStretching(I,image{1});   
     myHE(I,image{1});
     myAHE(I,strcat(image{1},' 201'),201);
     myCLAHE(I,strcat( image{1},' 121 0.001'),121,0.001);
end    
toc;
