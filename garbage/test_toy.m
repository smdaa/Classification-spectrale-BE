clear all;

load("ToyExample.mat")
writematrix(Data,'/home/smdaa/2021Cluster/examples2018/COORD/toy/toy.txt', 'Delimiter', ' ')

sigma = 4;
k     = 2;

[idx, L] = classification_spectrale(Data, k, sigma, 'N', 0);

Data1 = Data(:,1);
Data2 = Data(:,2);

figure(1),
scatter(Data1, Data2);

figure(2)
plot(Data1(idx == 1), Data2(idx == 1), 'r*');grid on;hold on
plot(Data1(idx == 2), Data2(idx == 2), 'b*');grid on;