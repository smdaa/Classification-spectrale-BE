function [idx, L, X] = classification_spectrale(S, k, sigma, sparsification, treshold)

A = pdist2(S, S, 'euclidean');

if strcmp(sparsification, 'Y')
    A(A > treshold) = 0;
    A = sparse(A);    
end

% Construction de la matrice affinité
if strcmp(sparsification, 'Y')
    A(A ~= 0) = exp(-A(A ~= 0).^2 ./ (2 * sigma^2));
else
    A = exp(-A.^2 ./ (2 * sigma^2));
end

A = A - diag(diag(A));

% Construction de la matrice normalisée L
if strcmp(sparsification, 'Y')
    L = A ./ sum(A(:));
else
    D_sqrt_inv = diag(sqrt(1 ./ sum(A, 2)));
    L          = D_sqrt_inv * A * D_sqrt_inv;    
end

% Construction de la matrice X formée à partir des k plus grandes vap de L
if strcmp(sparsification, 'Y')
    [X, ~] = eigs(L, k);
else
    [X, D] = eig(L);
    [~, indices_tri] = sort(diag(D), 'descend');
    X = X(:,indices_tri);
    X = X(:, 1:k);
end

% Construction de la matrice Y
Y = diag(1./ (sqrt(sum(X .^2 , 2)))) * X;

% Classification par kmeans
[idx, ~] = kmeans(Y, k);

end
