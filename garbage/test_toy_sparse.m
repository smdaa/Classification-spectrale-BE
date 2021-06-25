clear all;
clc;
close all;

load("ToyExample.mat")

sigma     = 1;
alpha     = 2.5;
treshold  = alpha * sigma;
k         = 2;

[idx, L] = classification_spectrale(Data, k, sigma, 'Y', treshold);

Data1 = Data(:,1);
Data2 = Data(:,2);

figure()
plot(Data1(idx == 1), Data2(idx == 1), 'g*');grid on;hold on
plot(Data1(idx == 2), Data2(idx == 2), 'b*');grid on;