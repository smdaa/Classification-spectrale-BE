clear all;
close all;
clc;

dataset  = 'croix';
k        = 2;

alpha_sd1 = 3;
alpha_sd2 = 3;
alpha_sd3 = 3;
alpha_sd4 = 3;


% Read Data
Data = readmatrix(['/home/smdaa/2021Cluster/examples2018/COORD/', dataset, '/', dataset, '.txt']);
Data = Data(2:end, :);

% first sd
Data_sd1 = Data(Data(:, 1) <= -1, :);
Data_sd1 = Data_sd1(Data_sd1(:, 2) >= 2, :);

Data_sd1_x = Data_sd1(:, 1);
Data_sd1_y = Data_sd1(:, 2);
figure()
axis equal
scatter(Data_sd1_x, Data_sd1_y)

% second sd
Data_sd2 = Data(Data(:, 1) >= -2, :);
Data_sd2 = Data_sd2(Data_sd2(:, 2) >= 2, :);

Data_sd2_x = Data_sd2(:, 1);
Data_sd2_y = Data_sd2(:, 2);
figure()
axis equal
scatter(Data_sd2_x, Data_sd2_y)
saveas(gcf,[dataset, 'sd2.png'])

% third sd
Data_sd3 = Data(Data(:, 1) <= -1, :);
Data_sd3 = Data_sd3(Data_sd3(:, 2) <= 3, :);

Data_sd3_x = Data_sd3(:, 1);
Data_sd3_y = Data_sd3(:, 2);
figure()
axis equal
scatter(Data_sd3_x, Data_sd3_y)
saveas(gcf,[dataset, 'sd3.png'])

% fourth sd
Data_sd4 = Data(Data(:, 1) >= -2, :);
Data_sd4 = Data_sd4(Data_sd4(:, 2) <= 3, :);

Data_sd4_x = Data_sd4(:, 1);
Data_sd4_y = Data_sd4(:, 2);
figure()
axis equal
scatter(Data_sd4_x, Data_sd4_y)
saveas(gcf,[dataset, 'sd4.png'])

Sigma_sd1 = .1;
Sigma_sd2 = .1;
Sigma_sd3 = .1;
Sigma_sd4 = .1;

% Colors 
colors = distinguishable_colors(k);

% Calcul Treshold
Treshold_sd1 = alpha_sd1 * Sigma_sd1;
Treshold_sd2 = alpha_sd2 * Sigma_sd2;
Treshold_sd3 = alpha_sd3 * Sigma_sd3;
Treshold_sd4 = alpha_sd4 * Sigma_sd4;

% Classification Spectrale
[idx1, L1, X1] = classification_spectrale(Data_sd1, k, Sigma_sd1, 'Y', Treshold_sd1);
[idx2, L2, X2] = classification_spectrale(Data_sd2, k, Sigma_sd2, 'Y', Treshold_sd2);
[idx3, L3, X3] = classification_spectrale(Data_sd3, k, Sigma_sd3, 'Y', Treshold_sd3);
[idx4, L4, X4] = classification_spectrale(Data_sd4, k, Sigma_sd4, 'Y', Treshold_sd4);


figure();
spy(L1);
saveas(gcf,[dataset, '1.png'])
disp(['sparsity of L1 ', num2str(nnz(L1) / size(Data_sd1, 1)^2)])
mtxwrite(L1, ['/home/smdaa/nosave/test_eigen/', dataset, '_sparse/', dataset, '1.mtx']);

figure();
spy(L2);
saveas(gcf,[dataset, '2.png'])
disp(['sparsity of L2 ', num2str(nnz(L2) / size(Data_sd2, 1)^2)])
mtxwrite(L2, ['/home/smdaa/nosave/test_eigen/', dataset, '_sparse/', dataset, '2.mtx']);

figure();
spy(L3);
saveas(gcf,[dataset, '3.png'])
disp(['sparsity of L3 ', num2str(nnz(L3) / size(Data_sd3, 1)^2)])
mtxwrite(L3, ['/home/smdaa/nosave/test_eigen/', dataset, '_sparse/', dataset, '3.mtx']);

figure();
spy(L4);
saveas(gcf,[dataset, '4.png'])
disp(['sparsity of L4 ', num2str(nnz(L4) / size(Data_sd4, 1)^2)])
mtxwrite(L4, ['/home/smdaa/nosave/test_eigen/', dataset, '_sparse/', dataset, '4.mtx']);

