% I = imread('file-page1.jpg');
% B = imresize(I,0.2);
% C = rgb2gray(B);
% D = im2bw(C,0.6);
% imshow(D);

D = im2bw(imread('new.png'),0.8);

C =10;

[m n] = size(D);
O = zeros(size(D));
for i=1:m
    for j=1:n-C
        patch = D(i,j:j+C-1);
        if sum(patch)==C
            O(i,j:j+C-1)=1;
        end
    end
end
C = 10;
O2 = zeros(size(D));
for i=1:n
    for j=1:m-C
        patch = D(j:j+C-1,i);
        if(sum(patch)==C)
            O2(j:j+C-1,i)=1;
        end
    end
end
figure
imshow(D);
figure            
imshow(O);
figure;
imshow(O2);
O3 = O2 | O;
figure;
imshow(O3);
figure;
O4 = O2 & O;
imshow(O4);
% xx = [ones(m,1)*D*ones(m,1)];
% xx = reshape(xx',1,[]);
% d = diff(xx);
% start = find(d==-1);
% stop = find(d==1);
% lgt = stop-start;
% b = lgt <= C;
% d(start(b)) = 0;
% d(stop(b)) = 0;
% yy = cumsum([1 d]);
% yy = reshape(yy, [], m)';
% y = yy(:,2:end-1)

%for i