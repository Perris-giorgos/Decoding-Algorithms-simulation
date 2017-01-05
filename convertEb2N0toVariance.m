function [s2] = convertEb2N0toVariance(signalPower, Eb2N0, codeRate)

%  [s2] = convertEb2N0toVariance(signalPower, Eb2N0, codeRate)
%
%            signalPower : the mean power of the input signal,
%                  Eb2N0 : Eb/N0 ratio on dB,
%               codeRate : the code rate of the channel coding. By default
%                          code rate is 0.5. In case that SNR on dB, insted
%                          of Eb/N0, is defined, codeRate input argument is
%                          ommited.

if ( 2==nargin )
    codeRate = 0.5;
end

SNR = Eb2N0 + 10*log10(2*codeRate);

s2 = signalPower./(10.^(SNR/10));

