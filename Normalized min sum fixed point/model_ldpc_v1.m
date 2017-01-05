% clc
clear

load H648_1_2.mat;
A = H;
%load data100frames;
%data=datas;
%%A=checkmatrix( 324  , 3  , 6 );
%H = dvbs2ldpc(codeRate);
codeRate =1/2;
Eb=1;
%%noisevariance=0.2;
[inCheck,inBit]=find(H);
indexLine=find(H);
nzero=nnz(H);
% noisevariance=[0.7079];%[0.001 0.1000 0.1259 0.1585 0.1995 0.2512 0.3162]; %[0.6607 0.4467   0.3981    0.3162    0.2512    0.1995  0.1259];
%  noisevariance=[0.001 0.1000 0.1259 0.1585 0.1995 0.2512 0.3162 0.3981 0.5012 0.6310 0.7943 1.0000];
noisevariance=[0.6166    0.6310    0.6457];
% noisevariance=[0.6166  0.6310 0.6607   0.6761  0.6918 0.7079 0.7943 1.0];

rounds=size(noisevariance,2);
max=zeros(1,rounds);
Eb2No=zeros(1,rounds);
L=50;                           %max iterations
frames=300;                     %max frames



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
     while errors<300
        counter(i)     = counter(i)+1;
        data           = logical(randi([0 1],324,1));
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
       [receivedBits, totalIter] = Normalized_min_sum_fixed_point(A, decoderInput, L, noisevariance(i), inBit, indexLine);  

        tempnewErrors=newErrors;
%         receivedBits = receivedBits(1:324)<=0;
        newErrors = nnz(receivedBits(1:324)-data)  ; 
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
    BER(i)= errors/(counter(i)*324)
    FER(i)=frameError/counter(i)
end
