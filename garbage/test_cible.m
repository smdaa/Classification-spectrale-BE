clear all;
clc;
close all;

% Read Data
Data = readmatrix('/home/smdaa/2021Cluster/examples2018/COORD/cible/cible.txt');

sigma = calculsigma(Data)
k     = 4;

[idx, L] = classification_spectrale(Data, k, sigma, 'N', 0);
Data1 = Data(:,1);
Data2 = Data(:,2);

figure(2)
plot(Data1(idx == 1), Data2(idx == 1), 'r*');grid on;hold on
plot(Data1(idx == 2), Data2(idx == 2), 'y*');grid on;hold on
plot(Data1(idx == 3), Data2(idx == 3), 'g*');grid on;hold on
plot(Data1(idx == 4), Data2(idx == 4), 'b*');grid on;