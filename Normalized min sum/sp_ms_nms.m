Eb2NO=[2.1 2   1.8   1.7 1.6    1.5   1.0 0];
Eb2NO2=[ 2   1.8   1.7 1.6    1.5   1.0 0];



BER50MS= [0.00633744855967078 0.00967078189300412 0.0251358024691358 0.0283338894450006 0.0350256623664863 0.0697128287707998 0.143237934904602 0.198302469135802];
BER50SP = [0.000311 0.001113 0.002963 0.00329 0.007074 0.042194 0.137412];
BERNMS075 = [0.000298353909465021	0.000524691358024691	0.00261316872427984	0.00369341563786008	0.00457818930041152	0.00846707818930041	0.0535334184759472	0.162605588044185];
BERNMS05 = [0.0111826802648059 0.0127665544332211 0.0169753086419753  0.0232863460475401 0.0228852309099223 0.0296002351557907  0.0724949755957508 0.142396184062851];
BERNMS08 = [0.000462962962962963 0.00256172839506173 0.00289094650205761 0.00405349794238683 0.00671810699588477 0.0110984271943176 0.0536398467432950 0.163092917478882];

figure
semilogy(Eb2NO2, BER50SP,'-*',  Eb2NO, BER50MS,'->', Eb2NO, BERNMS05,'-<', Eb2NO, BERNMS075,'-x', Eb2NO, BERNMS08)
legend('SP', 'MS', 'NMS a=0.5', 'NMS a=0.75', 'NMS a=0.8')

% Add title and axis labels
title('Ber plot  Eb=1')
xlabel('Eb/No (dB)')
ylabel('BER')