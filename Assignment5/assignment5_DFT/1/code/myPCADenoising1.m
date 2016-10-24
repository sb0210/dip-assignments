function [ im2 ] = myPCADenoising1( im, sigma2)
%% Your code here
im1 = padarray(im,[3, 3], 0,'both');
width = 128;
width2 = width^2;
P = zeros(49,width*width);
for i = 4:131
    for j=4:131
        k = (i-4)*128 + j-3;
        P(:,k) = reshape(im1(i-3:i+3,j-3:j+3),[1,49]);
    end
end

[V, D] = eig(P*P');

alpha = zeros(width*width,49);
alpha_ = zeros(49);
%N*49 = 49*N
alpha = P'*V;
for j =1:49
%     for i=1:width*width
%         alpha(i,j) = dot(P(:,i),V(:,j));   
%     end
    alpha_(j) = max(0,(sum(alpha(:,j).^2)-400)/width2);
end
alpha_denoise = zeros(size(alpha));
for j = 1:49
    alpha_denoise(:,j) = alpha(:,j)/(1+sigma2/alpha_(j));
end

P_denoise=zeros(size(P));

for i=1:width2
    for j=1:49
        P_denoise(:,i) = P_denoise(:,i) + alpha_denoise(i,j)*V(:,j);
    end
end
        

im2 = zeros(size(im));



for i=1:width
    for j=1:width
        
        l=max(1,i-3);
        r=min(width,i+3);
        t=max(1,j-3);
        b=min(width,j+3);
        s=0;

        for x=l:r
            for y=t:b
                k = (x-1)*128 + y;
                patch = reshape(P_denoise(:,k),[7,7]);
                s =s+ patch(4-x+i,4-y+j);
            end
        end
        im2(i,j)=s/((r-l+1)*(b-t+1));
    end
end
end

