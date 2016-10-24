%% MyMainScript

tic;
%% Your code here

directory = uigetdir();
[pathstr,name,ext] = fileparts(directory);
if strcmp(name,'CroppedYale')
    N=2415;
    image = zeros(N,32256);
    dir_files = dir(directory);
    ndirs = length(dir_files);
    training_count = 1;
    test_count = 1;
    for i = 1:ndirs
        current_dir_name = dir_files(i).name;
        if strcmp(current_dir_name,'.') || strcmp(current_dir_name,'..')
            continue
        end
        image_files = dir(strcat(directory,'\',current_dir_name));
        nfiles = length(image_files);
        
        for j = 1:nfiles
            current_file_name = image_files(j).name;
            if strcmp(current_file_name,'.') || strcmp(current_file_name,'..')
                continue
            end
            temp = imread(strcat(directory,'\',current_dir_name,'\',current_file_name));
            image(training_count,:) = reshape(temp,32256,1);
            training_count = training_count + 1;
        end
    end
    
    X = image';
    mean = (sum(X')/N)';
    for i = 1:N
        X(:,i) = X(:,i) - mean;
    end
    L = X'*X/(N-1);
    [W,D] = eigs(L,175);
    V = normc(X*W);
    
    test_image = image(170,:);
    index = 1;
    figure;
    imshow(reshape(test_image,192,168),[])
    saveas(gcf,'../images/test_image.png');
    figure;
    for k = [2,10,20,50,75,100,125,150,175]
        V_k = V(:,1:k); % d x k
        alpha = zeros(k,N);
        
        image_test = test_image' - mean;
        alpha_i_k = V_k'*image_test;  % k x d x d x 1
        reconstructed_image = V_k*alpha_i_k ; %d x k x k x 1
        reconstructed_image = reconstructed_image + mean;
        subplot(3,3,index);
        imshow(reshape(reconstructed_image,192,168),[]);
        index = index + 1;
    end
    saveas(gcf,'../images/reconstruction.png');
    figure
    for ii = 1:25
        subplot(5,5,ii);
        imshow(reshape(V(:,ii),192,168),[]);
    end
    saveas(gcf,'../images/top_25_eigen_vectors.png');
end

toc;