clear all;
close all;
clc;

% cible          k = 4      OK      alpha = 7
% sphere2        k = 2      OK      alpha = 3
% sphere2a       k = 2      OK      alpha = 3
% croix          k = 5      OK      alpha = 3     
% damier2        k = 25     OK      alpha = 5         Sigma = .2
% damier         k = 25     OK      alpha = 5         Sigma = .2
% aggregation    k = 7      OK      alpha = 7
% compound       k = 6      OK      alpha = 5         Sigma = .5
% jain           k = 2      OK      alpha = 3
% spiral         k = 3      OK      alpha = 3

dataset  = 'cible';
k        = 4;
alpha    = 7;

% Read Data
Data = readmatrix(['/home/smdaa/2021Cluster/examples2018/COORD/', dataset, '/', dataset, '.txt']);
Data = Data(2:end, :);

[n, p] = size(Data);
Data1 = Data(:,1);
Data2 = Data(:,2);
%scatter(Data1, Data2);

if p==3
    Data3 = Data(:, 3);
end

% Colors 
colors = distinguishable_colors(k);

% Calcul Sigma
Sigma = calculsigma(Data);
% pour damier
%Sigma = .5;

% Calcul Treshold
Treshold = alpha * Sigma;

% Classification Spectrale
[idx, L, X] = classification_spectrale(Data, k, Sigma, 'Y', Treshold);

% save L matrix to mtx format
%mtxwrite(L, ['/home/smdaa/nosave/test_eigen/', dataset, '_sparse/', dataset, '.mtx']);

% save eigen vectors to txt format
%X = flip(X, 2);
%writematrix(X, ['/home/smdaa/nosave/test_eigen/', dataset, '_sparse/X.txt'], 'Delimiter', ' ')

figure()
for i=1:k-1
   if p==3
       plot3(Data1(idx == i), Data2(idx == i),Data3(idx == i), 'color', colors(i, :), 'Marker', '*', 'LineStyle', 'none');grid on;hold on
   elseif p==2
       plot(Data1(idx == i), Data2(idx == i), 'color', colors(i, :), 'Marker', '*', 'LineStyle', 'none');grid on;hold on
   end
end
if p==3
    plot3(Data1(idx == k), Data2(idx == k),Data3(idx == k), 'color', colors(k, :), 'Marker', '*', 'LineStyle', 'none');grid on
elseif p==2
    plot(Data1(idx == k), Data2(idx == k), 'color', colors(k, :), 'Marker', '*', 'LineStyle', 'none');
end

saveas(gcf,[dataset, 'class.png'])

L1 = sparse(L(1:(n/4), :));
L2 = sparse(L((n/4)+1:(n/2), :));
L3 = sparse(L((n/2)+1:(3*n/4), :));
L4 = sparse(L((3*n/4)+1:end, :));

mtxwrite(L1, ['/home/smdaa/nosave/test_eigen/', dataset, '_sparse/', dataset, '1.mtx']);
mtxwrite(L2, ['/home/smdaa/nosave/test_eigen/', dataset, '_sparse/', dataset, '2.mtx']);
mtxwrite(L3, ['/home/smdaa/nosave/test_eigen/', dataset, '_sparse/', dataset, '3.mtx']);
mtxwrite(L4, ['/home/smdaa/nosave/test_eigen/', dataset, '_sparse/', dataset, '4.mtx']);


disp(nnz(L) / size(Data, 1)^2)
figure();
spy(L);
saveas(gcf,[dataset, '.png'])

figure();
spy(L1);
saveas(gcf,[dataset, '1.png'])

figure();
spy(L2);
saveas(gcf,[dataset, '2.png'])

figure();
spy(L3);
saveas(gcf,[dataset, '3.png'])

figure();
spy(L4);
saveas(gcf,[dataset, '4.png'])
