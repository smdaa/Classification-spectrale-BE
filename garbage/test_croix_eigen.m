clear all;

% Read Data
Data = readmatrix('/home/smdaa/2021Cluster/examples2018/COORD/croix/Croix.txt');
Data=Data(2:end, :);
figure();
scatter(Data(:,1), Data(:,2));

sigma = .5;
k     = 5;

% Construction de la matrice affinité
A = exp(-pdist2(Data, Data, 'euclidean').^2 ./ (2 * sigma ^ 2));
A = A - diag(diag(A));

% Construction de la matrice normalisée L
D_sqrt_inv = diag(sqrt(1 ./ sum(A, 2)));
L          = D_sqrt_inv * A * D_sqrt_inv;
%writematrix(L,'/mnt/nosave/smdaa/test_eigen/croix/croix.txt', 'Delimiter', ' ')

% Construction de la matrice X formée à partir des k plus grandes vap de L
[X, D] = eig(L);
[~, indices_tri] = sort(diag(D), 'descend');
X = X(:,indices_tri);
X = X(:, 1:k);
X = flip(X, 2);
%writematrix(X,'/mnt/nosave/smdaa/test_eigen/croix/V.txt', 'Delimiter', ' ')
