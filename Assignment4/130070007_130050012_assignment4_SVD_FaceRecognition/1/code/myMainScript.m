%% MyMainScript

tic;
%% Your code here

directory = uigetdir();
[pathstr,name,ext] = fileparts(directory);
if strcmp(name,'CroppedYale')
    N=1520;
    image = zeros(1520,32256);
    test_images = zeros(760,32256);
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

        count = 0;
        for j = 1:nfiles
            if count >=60
                break;
            end
            current_file_name = image_files(j).name;
            if strcmp(current_file_name,'.') || strcmp(current_file_name,'..')
                continue
            end
            temp = imread(strcat(directory,'\',current_dir_name,'\',current_file_name));
            if  count<40
                image(training_count,:) = reshape(temp,32256,1);
                training_count = training_count + 1;
            else
                test_images(test_count,:) = reshape(temp,32256,1);
                test_count = test_count + 1;
            end
            count = count + 1;
        end
    end


    X = image';
    mean = (sum(X')/N)';
    for i = 1:1520
        X(:,i) = X(:,i) - mean;
    end

    L = X'*X/(N-1);
    [W,~] = eigs(L,1003);
    V = normc(X*W);
    recognition_rate = zeros(17,2);
    recognition_rate(:,1) = [1,2,3,5,10,15,20,30,50,60,65,75,100,200,300,500,1000]';
    
    index = 1;
    for k = recognition_rate(:,1)'
        V_k = V(:,1:k); % d x k
        alpha = zeros(k,N);
        for i = 1:N
            alpha(:,i) = V_k'*X(:,i);
        end

        num = 0;
        denom = 0;
        for j = 1:38*20
            image_test = test_images(j,:)' - mean;
            alpha_i_k = V_k'*image_test;  % k x d x d x 1

            distance = zeros(N,1);
            for i = 1:N
                distance(i) = sum((alpha_i_k - alpha(:,i)).^2);
            end
            [~, arg_min_dist] = min(distance);
            if abs(floor((arg_min_dist-1)/40) - floor((j-1)/20))<0.001
                num = num +1;
            end
            denom = denom + 1;
        end
        recognition_rate(index,2) = num/denom;
        index = index + 1;
    end
    figure
    name = 'Yale Database - All eigen coefficients';
    plot(recognition_rate(:,1),recognition_rate(:,2)), xlabel('k'), ylabel('Recognition rate'), title(name),
    saveas(gcf,strcat('../images/',name,'.png'))    ;
    
    index = 1;
    offset = 3;
    for k = recognition_rate(:,1)'
        V_k = V(:,1+offset:k+offset); % d x k
        alpha = zeros(k,N);
        for i = 1:N
            alpha(:,i) = V_k'*X(:,i);
        end

        num = 0;
        denom = 0;
        for j = 1:38*20
            image_test = test_images(j,:)' - mean;
            alpha_i_k = V_k'*image_test;  % k x d x d x 1

            distance = zeros(N,1);
            for i = 1:N
                distance(i) = sum((alpha_i_k - alpha(:,i)).^2);
            end
            [~, arg_min_dist] = min(distance);
            if abs(floor((arg_min_dist-1)/40) - floor((j-1)/20))<0.001
                num = num +1;
            end
            denom = denom + 1;
        end
        recognition_rate(index,2) = num/denom;
        index = index + 1;
    end
    figure
    name = 'Yale Database - Excluding top 3 eigen coefficients';
    plot(recognition_rate(:,1),recognition_rate(:,2)), xlabel('k'), ylabel('Recognition rate'), title(name);
    saveas(gcf,strcat('../images/',name,'.png'));
else
    N=192;
    image = zeros(192,10304);
    test_images = zeros(32*4,10304);
    for i = 1:32
        for j = 1:6
            temp = imread(strcat(directory,'/s',num2str(i),'/',num2str(j),'.pgm'));
            image(6*i+j-6,:) = reshape(temp,10304,1);
        end
        for j = 1:4
            temp = imread(strcat(directory,'/s',num2str(i),'/',num2str(j+6),'.pgm'));
            test_images(4*i+j-4,:) = reshape(temp,10304,1);
        end
    end


    X = image';
    mean = (sum(X')/N)';
    for i = 1:N
        X(:,i) = X(:,i) - mean;
    end
    L = X'*X/(N-1);
    [W,~] = eigs(L,173);
    V = normc(X*W);

    recognition_rate = zeros(13,2);
    recognition_rate(:,1) = [1,2,3,5,10,15,20,30,50,75,100,150,170]';
    
    index = 1;
    for k = recognition_rate(:,1)'
        V_k = V(:,1:k); % d x k
        alpha = zeros(k,N);
        for i = 1:N
            alpha(:,i) = V_k'*X(:,i);
        end

        num = 0;
        denom = 0;
        for j = 1:128
            image_test = test_images(j,:)' - mean;
            alpha_i_k = V_k'*image_test;  % k x d x d x 1

            distance = zeros(N,1);
            for i = 1:192
                distance(i) = sum((alpha_i_k - alpha(:,i)).^2);
            end
            [~, arg_min_dist] = min(distance);
            if abs(floor((arg_min_dist-1)/6) - floor((j-1)/4))<0.001
                num = num +1;
            end
            denom = denom + 1;
        end
        recognition_rate(index,2) = num/denom;
        index = index + 1;
    end
    name = 'ORL Database';
    figure
    plot(recognition_rate(:,1),recognition_rate(:,2)), xlabel('k'), ylabel('Recognition rate'), title(name),
    saveas(gcf,strcat('../images/',name,'.png'));    
end
        
toc;
