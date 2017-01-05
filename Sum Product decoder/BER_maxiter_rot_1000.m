% Create some data
Eb2NO =  [7 6 5 4 3 2 1 0];
Eb2NO2=[2.1 2   1.8   1.7 1.6    1.5   1.0 0];
%Eb=1
BER1=[0.0003 0.0018 0.007 0.0205 0.0431 0.0748 0.11 0.1482];
BER5=[0 0 0 3.0864e-05 7.34567e-04 0.0169 0.0775 0.1396];
BER10=[0.0014 0.0021 0.0062 0.0101 0.0143 0.0159 0.0554 0.1406];
BER20=[0.0002583 0.0005719 0.0018258 0.0028816 0.0070686 0.0125955 0.0541187 0.1363392];
BER30=[0.0001449 0.0001942 0.0016  0.0033 0.0048 0.0062 0.0427 0.1449];
BER50=[0 0.000311 0.001113 0.002963 0.00329 0.007074 0.042194 0.137412];
BER60=[1.233334e-05 0.000453 0.001073 0.001924 0.003689 0.007204 0.040604 0.132073];
BER80=[0.000293 0.0003083 0.0010 0.0018 0.0041 0.0061 0.0509 0.1323];
% Create a y-axis semilog plot using the semilogy function
figure
semilogy(Eb2NO, BER1, Eb2NO, BER5, Eb2NO2, BER10, Eb2NO2, BER20, Eb2NO2, BER30, Eb2NO2, BER50, Eb2NO2, BER60, Eb2NO2, BER80)
legend('1 iteration','5 iterations','10 iterations', '20 iteratins', '30 iterations','50iterations','60 iterations', '80 iterations')
%set(g,'yscale','log')

grid on

% Add title and axis labels
title('Ber plot  Eb=1 500frames')
xlabel('Eb/No (dB)')
ylabel('BER')