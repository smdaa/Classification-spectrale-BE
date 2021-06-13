clear all;

load("ToyExample.mat")

sigma = .5;

idx = classification_spectrale(Data, 2, sigma);

Data1 = Data(:,1);
Data2 = Data(:,2);

figure(1),
scatter(Data1, Data2);

figure(2)
plot(Data1(idx == 1), Data2(idx == 1), 'r*');grid on;hold on
plot(Data1(idx == 2), Data2(idx == 2), 'b*');grid on;