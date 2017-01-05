% clc
clear

% load basex1.mat 
% A = hx1b;
load H648_1_2.mat;
A = H;
%load data100frames;
%data=datas;
%%A=checkmatrix( 324  , 3  , 6 );
%H = dvbs2ldpc(codeRate);
variables = size(A, 1);

codeRate =1/2;
Eb=1;
%%noisevariance=0.2;
[inCheck,inBit]=find(A);
indexLine=find(A);
nzero=nnz(A);
% noisevariance=[1];%[0.001 0.1000 0.1259 0.1585 0.1995 0.2512 0.3162 0.3981 0.5012]; %[0.7079];%[0.6607 0.4467   0.3981    0.3162    0.2512    0.1995  0.1259];
%  noisevariance=[0.001 0.1000 0.1259 0.1585 0.1995 0.2512 0.3162 0.3981 0.5012 0.6310 0.7943 1.0000];
% noisevariance=[0.3981 0.5012 0.6166  0.6310 0.6607   0.6761  0.6918 0.7079 0.7943 1.0];
% noisevariance=[0.6166  0.6310 0.6607   0.6761  0.6918 0.7079 0.7943 1.0];
noisevariance = [0.7079];%[0.595662143529011,0.602559586074358,0.609536897240169,0.616595001861482,0.623734835482419,0.630957344480193,0.638263486190549,0.645654229034656,0.653130552647472,0.660693448007596,0.668343917568615,0.676082975391982,0.683911647281429,0.691830970918937,0.707945784384138,0.794328234724282,0.85, 0.9, 0.95, 1];
rounds=size(noisevariance,2);
max=zeros(1,rounds);
Eb2No=zeros(1,rounds);
L=50;                           %max iterations
frames=500;                     %max frames



c=[1 -1];
hMod = comm.GeneralQAMModulator(c);
hEnc = comm.LDPCEncoder(A);
%hAWGN = comm.AWGNChannel('NoiseMethod','Variance', 'VarianceSource', 'Property','Variance',noisevariance );
%hDemod = comm.GeneralQAMDemodulator(c, 'BitOutput', true, 'DecisionMethod', 'Log-likelihood ratio');
hDec = comm.LDPCDecoder(H, 'DecisionMethod', 'Soft decision' );
frameError=0;

for i =1:rounds
    errors=0;
    newErrors=0;
    frameError=0;
    counter(i)=0;
%Lc=2*sqrt(codeRate*Eb)/noisevariance(i);
    %hAWGN = comm.AWGNChannel('NoiseMethod','Variance', 'VarianceSource', 'Property','Variance',noisevariance(i) );
    
    %for counter = 1:frames
     while errors<500
        counter(i)     = counter(i)+1;
        data           = logical(randi([0 1],variables,1));
        encodedData    = step(hEnc, data);
        modSignal      = step(hMod, encodedData);
        [decoderInput, Eb2No] = AWGN_v1(modSignal, noisevariance(i), 0.5);
        %receivedSignal = step(hAWGN, modSignal);
        %demodSignal    = step(hDemod, receivedSignal);
%        receivedBits   = step(hDec, decoderInput);                                                                        %matlab decoder
        %decoderInput = real(receivedSignal);
%         decoderInput = demodSignal;

%        receivedBits = ldpcsoft5_kalo(A, decoderInput, L, noisevariance(i), codeRate, Eb, inCheck, inBit, indexLine, nzero) ;
%        receivedBits   = ldpcsoft5_fixed_point_ready(A, decoderInput, L, noisevariance(i), codeRate, Eb, inCheck, inBit, indexLine);  %my gallagher decoder
%        [receivedBits, totalIter] = ldpcsoft5_fixed_point(A, decoderInput, L, noisevariance(i), codeRate, Eb, inCheck, inBit, indexLine);
%        [receivedBits, totalIter] = minsum_v4(A, decoderInput, L, noisevariance(i), inBit, indexLine);  
% 	     [receivedBits, totalIter] = minsum_fixed_point(A, decoderInput, L, noisevariance(i), inBit, indexLine);  
%        [receivedBits, totalIter] = Normalized_min_sum(A, decoderInput, L, noisevariance(i), inBit, indexLine);  
%        [receivedBits, totalIter] = Normalized_min_sum_fixed_point(A, decoderInput, L, noisevariance(i), inBit, indexLine);  
%        [receivedBits, totalIter] = Belief_propagation(A, decoderInput, L, noisevariance(i), codeRate, Eb, inCheck, inBit, indexLine);
       [receivedBits, totalIter] = Belief_propagation1(A, decoderInput, L, noisevariance(i), codeRate, Eb, inCheck, inBit, indexLine);
        tempnewErrors=newErrors;
%         receivedBits = receivedBits(1:324)<=0;
        newErrors = nnz(receivedBits(1:variables)-data)  ; 
        if newErrors>tempnewErrors
            max(i)=newErrors;
        end
        errors=errors+newErrors;
        if newErrors>0
            frameError=frameError+1;
        end
        counter;
        if counter==frames
            break;
        end
        
     end

    noisevariance(i)
    BER(i)= errors/(counter(i)*variables)
    FER(i)=frameError/counter(i)
end
