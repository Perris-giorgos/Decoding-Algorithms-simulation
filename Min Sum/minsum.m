EB2NO =  [10 9 8 7 6 5 4 3 2 1 0];
EB2NO2=[2.1 2 1.8 1.7 1.6 1.5 1.0 0];

BER1 = [ 0 0 6.17283950617284e-05 0.000231481481481482 0.00195987654320988 0.00714506172839506 0.0196905766526020 0.0454793028322440 0.0782407407407407 0.125830959164293 0.162345679012346];
BER5 = [0 0 0 0 0 0 0 0.00189300411522634 0.0377898223426679 0.120370370370370 0.198688271604938];
BER10 = [0.00907064471	0.0235449735449	0.0169255276782	0.0319535221496	0.0491103848946	0.10262345679	0.134773662551	0.1985];
BER20 = [0.00855967078189300 0.0102263374485597 0.0310169905879477 0.0460239651416122 0.0460758377425044 0.0638271604938272 0.119301994301994 0.218518518518519];
BER30 = [0.00668724279	0.0090740740740	0.0219029374201	0.0439054077551	0.0456007650843	0.04134178037	0.114748677248	0.199074074];
BER40 = [0.00640946502057613	0.0146999712891186	0.0177000204624514	0.0303003323836657	0.0343867418142780	0.0648778029730411	0.113205467372134	0.202546296296296 ]; 
BER50 = [0.00633744855967078 0.00967078189300412 0.0251358024691358 0.0283338894450006 0.0350256623664863 0.0697128287707998 0.143237934904602 0.198302469135802];
figure
semilogy(EB2NO, BER1, EB2NO,  BER5, EB2NO2, BER10, EB2NO2, BER20, EB2NO2, BER30, EB2NO2, BER40, EB2NO2, BER50 );
legend('1 iter','5 iter','10 iter','20 iter','30 iter', '40 iter','50 iter')

title('Ber plot  Eb=1 500frames')
xlabel('Eb/No (dB)')
ylabel('BER')