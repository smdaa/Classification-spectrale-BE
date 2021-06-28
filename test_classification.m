clear all;
close all;
clc;

% sphere2        k = 2      OK      alpha = 3
% sphere2a       k = 2      OK      alpha = 3
% cible          k = 4
% toy            k = 2
% croix          k = 5      OK      alpha = 3
% spiral         k = 3      OK      alpha = 3
% damier         k = 25     OK      alpha = 1.5   
dataset  = 'damier';
k        = 25;
alpha    = 1.5;


% Read Data
Data = readmatrix(['/home/smdaa/2021Cluster/examples2018/COORD/', dataset, '/', dataset, '.txt']);
Data=Data(2:end, :);
%Data = Data(:, 1:2);
n    = size(Data, 2);
Data1 = Data(:,1);
Data2 = Data(:,2);
if n==3
    Data3 = Data(:, 3);
end

% Colors 
colors = distinguishable_colors(k);

% Calcul Sigma
Sigma = calculsigma(Data);
Sigma = .5;

% Calcul Treshold
Treshold = alpha * Sigma;

% Classification Spectrale
[idx, L, X] = classification_spectrale(Data, k, Sigma, 'Y', Treshold);

% save L matrix to mtx format
mtxwrite(L, ['/home/smdaa/nosave/test_eigen/', dataset, '_sparse/', dataset, '.mtx']);

% save eigen vectors to txt format
X = flip(X, 2);
writematrix(X, ['/home/smdaa/nosave/test_eigen/', dataset, '_sparse/V.txt'], 'Delimiter', ' ')

figure()
for i=1:k-1
   if n==3
       plot3(Data1(idx == i), Data2(idx == i),Data3(idx == i), 'color', colors(i, :), 'Marker', '*', 'LineStyle', 'none');grid on;hold on
   elseif n==2
       plot(Data1(idx == i), Data2(idx == i), 'color', colors(i, :), 'Marker', '*', 'LineStyle', 'none');grid on;hold on
   end
end
if n==3
    plot3(Data1(idx == k), Data2(idx == k),Data3(idx == k), 'color', colors(k, :), 'Marker', '*', 'LineStyle', 'none');grid on
elseif n==2
    plot(Data1(idx == k), Data2(idx == k), 'color', colors(k, :), 'Marker', '*', 'LineStyle', 'none');grid on
end

disp(nnz(L) / size(Data, 1)^2)
