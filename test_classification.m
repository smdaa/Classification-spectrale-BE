clear all;
close all;
clc;

% sphere2        k = 2
% sphere2a       k = 2
% cible          k = 4
% toy            k = 2
% croix          k = 5
dataset = 'cible';
k       = 4;

% Read Data
Data = readmatrix(['/home/smdaa/2021Cluster/examples2018/COORD/', dataset, '/', dataset, '.txt']);
%Data=Data(2:end, :);
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

% Calcul Treshold
alpha    = 2.5;
Treshold = alpha * Sigma;

% Classification Spectrale
[idx, L, X] = classification_spectrale(Data, k, Sigma, 'Y', Treshold);

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
