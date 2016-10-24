function [ U, S, V ] = mySVD( A )

    [m1,n1] = size(A);
    if m1 == min(m1,n1)
        A = A';
    end
    [~,n] = size(A);
    S = zeros(size(A));
    [V,D] = eig(A'*A);
    D = D.^0.5;
    D = rot90(D,2);
    S(1:n,1:n)=D(:,:);
    V1 = fliplr(V);
    US = A*V1;
    U1 = US/S;
    
    V = V1;
    U = U1;
    
    if m1 == min(m1, n1)
        V = U1;
        U = V1;
        S = S';
    end
end

