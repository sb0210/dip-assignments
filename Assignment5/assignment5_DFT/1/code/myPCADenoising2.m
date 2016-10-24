function [ im2 ] = myPCADenoising2( im, sigma2 )

    im1 = padarray(im,[3, 3], 0,'both');
    width = 128;
    width2 = width^2;
    P = zeros(49,width*width);
    P_denoise = zeros(49,width*width);

    Q=zeros(49,200);

    for i = 4:131
        for j=4:131
            k=(i-4)*128+j-3;
            P(:,k) = reshape(im1(i-3:i+3,j-3:j+3),[1,49]);
        end
    end


    for i = 4:131
        for j=4:131
            l=max(4,i-15);
            r=min(width+3,i+15);
            t=max(4,j-15);
            b=min(width+3,j+15);
            k1=(i-4)*128+j-3;
           
            patch = P(:,k1);
            windowsize = (r-l+1)*(t-b+1);
            errors = zeros((r-l+1)*(t-b+1));
            patch_n = zeros(49,(l-r+1)*(t-b+1));
            k3 =1;
            for x=l:r
                for y=t:b
                    k2=(x-4)*128+y-3;
                    errors(k3)= RMSD(patch,P(:,k2));
                    patch_n(:,k3) = P(:,k2);
                    k3=k3+1;
                end
            end
            [~,sortingIndices] = sort(errors,'ascend');
            for x=1:200
                Q(:,x)= patch_n(:,sortingIndices(x));
            end
            [V, D] = eig(Q*Q');


            alpha = zeros(200,49);
            alpha_ = zeros(49);
            alpha = Q'*V;

            for x =1:49
                alpha_(x) = max(0,(sum(alpha(:,x).^2)-400)/200);
            end
            alpha_denoise = zeros(49);
            for x = 1:49
                alpha_denoise(x) = alpha(1,x)/(1+sigma2/alpha_(x));
            end

            for x=1:49
                P_denoise(:,k1) = P_denoise(:,k1) + alpha_denoise(x)*V(:,x);
            end
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

