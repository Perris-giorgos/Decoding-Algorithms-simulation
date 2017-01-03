function [Eb2N0] = convertVariancetoEb2N0(s2)

Ps = 1;
codeRate = 0.5;

tmp=Ps./s2;
SNR=10*log10(tmp);
Eb2N0 = SNR - 10*log10(2*codeRate);