function [ output_args ] = myHarrisCornerDetector(orig_img, sig1, sig2, k )

    win = 11;
    mask2 = fspecial('gaussian', [win, win], sig1);
    mark_img = orig_img;
    img = conv2(orig_img, mask2, 'same');
    dx = [-1 0 1; -2 0 2; -1 0 1];
    Ix = conv2(img, dx, 'same');
    Iy = conv2(img, dx', 'same');
    Ix2 = Ix.^2;
    Iy2 = Iy.^2;
    Ixy = Ix.*Iy;
    mask2 = fspecial('gaussian', [win, win], sig2);
    
    Sx2 = conv2(Ix2, mask2, 'same');
    Sy2 = conv2(Iy2, mask2, 'same');
    Sxy = conv2(Ixy, mask2, 'same');
    
    [rows, cols] = size(img);
    eigen1 = zeros(rows, cols);
    eigen2 = zeros(rows, cols);
    cornerness = zeros(rows, cols);
    n=0;
    for i=1:rows
        for j=1:cols
            A = [Sx2(i,j) Sxy(i,j); Sxy(i,j) Sy2(i,j)];
            e = eig(A);
            eigen1(i,j) = max(e);
            eigen2(i,j) = min(e);
            cornerness(i,j) = max(0,det(A) - k * trace(A)*trace(A));
        end
    end
    paddedimage = padarray(cornerness, [1,1]);
    for i=1:rows
		for j=1:cols
			if max(max(paddedimage(i:i+2,j:j+2)))== paddedimage(i+1,j+1) && cornerness(i,j)>0.1
                 mark_img = insertMarker(mark_img,[j i]);
			end	
        end
    end
    displayImage(orig_img,'Original Image');
    displayImage(Ix,'X Derivative with Sign');
    displayImage(abs(Ix),'X Derivative Magnitude');
    displayImage(Iy,'Y Derivative with Sign');
    displayImage(abs(Iy),'Y Derivative Magnitude');
    displayImage(eigen1,'Max Eigen Value');
    displayImage(eigen2,'Min Eigen Value');
    displayImage(cornerness,'Cornerness Measure');
    displayImage(mark_img,'Original Image with corner Markers');
end




