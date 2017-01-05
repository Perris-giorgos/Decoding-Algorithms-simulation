function [noisedSignal, Eb2N0] = AWGN_v1(signal, s2, codeRate)

%  [noisedSignal, s, Ps, noise] = AWGN(signal, Eb2N0, codeRate)
%
%     White Gaussian Noise Addition on the signal. Mean value of added Noise
%    is zero. Its power is appropriate in order to have Eb/N0 equal to the
%    input argument Eb2N0.
%           noisedSignal : the noised signal,
%                     s2 : the noise variance,
%                     Ps : the mean power of the input signal,
%                 signal : the input signal to the channel,
%                  Eb2N0 : Eb/N0 ratio on dB,
%                  noise : the added noise,
%               codeRate : the code rate of the channel coding. By default
%                          code rate is 0.5. In case that SNR on dB, insted
%                          of Eb/N0, is defined, codeRate input argument is
%                          ommited.

if ( 2==nargin )
    codeRate = 0.5;
end

N = length(signal);

%SNR = Eb2N0 + 10*log10(2*codeRate);

Ps = (double(signal)'*double(signal))/length(signal);
%s2 = Ps/(10^(SNR/10));
tmp=Ps/s2;
SNR=10*log10(tmp);
Eb2N0 = SNR - 10*log10(2*codeRate);

noise = sqrt(s2)*randn(1,N);
noisedSignal = signal + noise';
