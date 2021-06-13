function idx = classification_spectrale(S, k, sigma)

% Construction de la matrice affinité
A = exp(-pdist2(S, S, 'euclidean').^2 ./ (2 * sigma ^ 2));

% Construction de la matrice normalisée L
D_sqrt_inv = diag(sqrt(1 ./ sum(A, 2)));
L          = D_sqrt_inv * A * D_sqrt_inv;

% Construction de la matrice X formée à partir des k plus grandes vap de L
[X, D] = eig(L);
[~, indices_tri] = sort(diag(D), 'descend');
X = X(:,indices_tri);
X = X(:, 1:k);

% Construction de la matrice Y
Y = diag(1./ (sqrt(sum(X .^2 , 2)))) * X;

% Classification par kmeans
[idx, ~] = kmeans(Y, k);

end

