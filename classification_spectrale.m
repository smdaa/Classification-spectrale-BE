function [idx, L, X] = classification_spectrale(S, k, sigma, sparsification, treshold)

if strcmp(sparsification, 'Y')
    
    A = pdist2(S, S, 'euclidean');
    A(A > treshold) = 0;    
    A = sparse(A);
    A(A ~= 0) = exp(-A(A ~= 0).^2 ./ (2 * (sigma^2)));
    D_sqrt_inv = sparse(diag(sqrt(1 ./ sum(A, 2))));
    L          = sparse(D_sqrt_inv * A * D_sqrt_inv);
    [X, ~] = eigs(L, k, 'largestabs', 'MaxIterations', 2000, 'Tolerance',1e-14);
    %[X, ~] = eigs(L, k);
else
    
    A = exp(-pdist2(S, S, 'euclidean').^2 ./ (2 * (sigma^2)));
    A = A - diag(diag(A));
    D_sqrt_inv = diag(sqrt(1 ./ sum(A, 2)));
    L          = D_sqrt_inv * A * D_sqrt_inv;
    [X, D] = eig(L);
    [~, indices_tri] = sort(diag(D), 'descend');
    X = X(:,indices_tri);
    X = X(:, 1:k);
    
end

% Construction de la matrice Y
Y = diag(1./ (sqrt(sum(X .^ 2 , 2)))) * X;

% Classification par kmeans
[idx, ~] = kmeans(Y, k);

end
