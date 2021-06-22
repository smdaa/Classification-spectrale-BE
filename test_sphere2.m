% Read Data
Data = readmatrix('/home/smdaa/2021Cluster/examples2018/COORD/sphere2/sphere2.txt');
Data=Data(2:end, :);
figure();

sigma = .2;
k     = 2;

[idx, D] = classification_spectrale(Data, k, sigma);
Data1 = Data(:,1);
Data2 = Data(:,2);
Data3 = Data(:,3);

figure(2)
plot3(Data1(idx == 1), Data2(idx == 1),Data3(idx == 1), 'r*', 'MarkerSize',15);grid on;hold on
plot3(Data1(idx == 2), Data2(idx == 2),Data3(idx == 2), 'y*', 'MarkerSize',15);grid on
%plot3(Data1(idx == 3), Data2(idx == 3),Data3(idx == 3),  'g*', 'MarkerSize',15);grid on
