
EB2NO2=[2.1 2 1.8 1.7 1.6 1.5 1.0 0];
EB2NO=[4 3 2.1 2 1.8 1.7 1.6 1.5 1.0 0];

BER32_26 = [0.00451388888888889 0.00864027947361281 0.0198712086572169 0.0273627969706401 0.0439709115508202 0.0572089947089947 0.139425657541600 0.190450254175744];
BER16_12 = [0.00331018518518519,0.00639660493827161,0.0173673673673674,0.0285779606767261,0.0413580246913580,0.0798512187401076,0.119776828110161,0.195601851851852];
BER8_5 = [0.00925925925925926,0.00733111388542100,0.0203460038986355,0.0244953948657652,0.0358926342072409,0.0553931124106563,0.158487654320988,0.210905349794239];
BER6_2 = [0.0131468347780405,0.0197802624427362,0.0370370370370370,0.0513054037644202,0.0614258048898572,0.0624691358024691,0.143237934904602,0.215020576131687];
BER4_2 = [0.0125000000000000,0.00750000000000000,0.0700808625336927,0.122549019607843,0.258426966292135,0.223300970873786,0.369230769230769,0.448979591836735,0.863636363636364,1];
BER50 = [0.00633744855967078 0.00967078189300412 0.0251358024691358 0.0283338894450006 0.0350256623664863 0.0697128287707998 0.143237934904602 0.198302469135802];

figure
semilogy(EB2NO2, BER50,'+-', EB2NO, BER4_2,'p-', EB2NO2, BER16_12,'*-',EB2NO2, BER32_26,'>-')

legend('Min sum floating point','Min sum 4Wl 2FB','Min sum 16Wl 12FB','Min sum 32Wl 26FB')



grid on
title('Ber plot  MS fixed point')
xlabel('Eb/No (dB)')
ylabel('BER')