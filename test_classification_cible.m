clear all;
close all;
clc;

dataset  = 'cible';
k        = 4;

alpha_sd1 = 7;
alpha_sd2 = 7;

% Read Data
Data = readmatrix(['/home/smdaa/2021Cluster/examples2018/COORD/', dataset, '/', dataset, '.txt']);
Data = Data(2:end, :);

[n, p] = size(Data);

Data_sd1 = Data(Data(:, 2) >= -5, :);
Data_sd2 = Data(Data(:, 2) <= 5, :);

Data_sd1_x = Data_sd1(:, 1);
Data_sd1_y = Data_sd1(:, 2);

Data_sd2_x = Data_sd2(:, 1);
Data_sd2_y = Data_sd2(:, 2);

Sigma_sd1 = .7;
Sigma_sd2 = .7;

%figure()
%axis equal
%scatter(Data_sd1(:, 1), Data_sd1(:, 2));
%saveas(gcf,[dataset, 'sd1.png'])

%figure()
%axis equal
%scatter(Data_sd2(:, 1), Data_sd2(:, 2));
%saveas(gcf,[dataset, 'sd2.png'])

if p==3
    Data3 = Data(:, 3);
end

% Colors 
colors = distinguishable_colors(k);

% Calcul Treshold
Treshold_sd1 = alpha_sd1 * Sigma_sd1;
Treshold_sd2 = alpha_sd2 * Sigma_sd2;

% Classification Spectrale
[idx1, L1, X1] = classification_spectrale(Data_sd1, k, Sigma_sd1, 'Y', Treshold_sd1);
[idx2, L2, X2] = classification_spectrale(Data_sd2, k, Sigma_sd2, 'Y', Treshold_sd2);


figure()
for i=1:k-1
    axis equal
    plot(Data_sd1_x(idx1 == i), Data_sd1_y(idx1 == i), 'color', colors(i, :), 'Marker', '*', 'LineStyle', 'none');grid on;hold on
end
axis equal
plot(Data_sd1_x(idx1 == k), Data_sd1_y(idx1 == k), 'color', colors(k, :), 'Marker', '*', 'LineStyle', 'none');

saveas(gcf,[dataset, '1class.png'])


figure()
for i=1:k-1
    axis equal
    plot(Data_sd2_x(idx2 == i), Data_sd2_y(idx2 == i), 'color', colors(i, :), 'Marker', '*', 'LineStyle', 'none');grid on;hold on
end
axis equal
plot(Data_sd2_x(idx2 == k), Data_sd2_y(idx2 == k), 'color', colors(k, :), 'Marker', '*', 'LineStyle', 'none');

saveas(gcf,[dataset, '2class.png'])

%figure();
%spy(L1);
%saveas(gcf,[dataset, '1.png'])
disp(['sparsity of L1 ', num2str(nnz(L1) / size(Data_sd1, 1)^2)])
%mtxwrite(L1, ['/home/smdaa/nosave/test_eigen/', dataset, '_sparse/', dataset, '1.mtx']);

%figure();
%spy(L2);
%saveas(gcf,[dataset, '2.png'])
disp(['sparsity of L2 ', num2str(nnz(L2) / size(Data_sd2, 1)^2)])
%mtxwrite(L2, ['/home/smdaa/nosave/test_eigen/', dataset, '_sparse/', dataset, '2.mtx']);

