%% MyMainScript

tic;
%% Your code here
directory = uigetdir();
N=192;
    image = zeros(192,10304);
    test_images = zeros(40*4,10304);
    for i = 1:32
        for j = 1:6
            temp = imread(strcat(directory,'/s',num2str(i),'/',num2str(j),'.pgm'));
            image(6*i+j-6,:) = reshape(temp,10304,1);
        end
    end
    
    for i = 1:40
        for j = 1:4
            temp = imread(strcat(directory,'/s',num2str(i),'/',num2str(j+6),'.pgm'));
            test_images(4*i+j-4,:) = reshape(temp,10304,1);
        end
    end

    X = image';
    mean = (sum(X')/N)';
    Y = diag(mean)*ones(size(X));
    X = X - Y;
    L = X'*X/(N-1);
    [W,D] = eigs(L,100);
    V = normc(X*W);


    false_positives = 0;
    false_negatives = 0;
    k = 100;
    threshold = 10^6 * 6.5;
    V_k = V(:,1:k); % d x k
    alpha = zeros(k,N);
    for i = 1:N
        alpha(:,i) = V_k'*X(:,i);
    end

    num = 0;
    denom = 0;
    for j = 1:160
        image_test = test_images(j,:)' - mean;
        alpha_i_k = V_k'*image_test;  % k x d x d x 1

        distance = zeros(N,1);
        min_distance = 0;
        for i = 1:192
            distance(i) = sum((alpha_i_k - alpha(:,i)).^2);
        end
        [min_dist, arg_min_dist] = min(distance);
        if min_dist > threshold %min_dist>thrshold => person not in database
            if j<128
                false_negatives = false_negatives + 1;
            end
        else
            if j> 128 %person in database
                false_positives = false_positives +1;
            end
        end
    end
        
        disp([false_positives, false_negatives])
toc;
