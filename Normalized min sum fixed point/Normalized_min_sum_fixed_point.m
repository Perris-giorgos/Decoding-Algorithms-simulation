function [x ,iteration] = Normalized_min_sum_fixed_point(A, r, L, Nv, inB, inL) 
    % A = parity check matrix
    % r = received signal vector
    % L = number of iterations
    % Nv= noisevariance
    % Lc= channel reliability
    % [inC,inB]=find(A)
    % inL=find(A)
    % nzero= non zero elements
    
    a = 0.75;

    % +1bit for signed 
    worldLength = 8;
    fractionalBits = 5;
%     integerBits = worldLength - fractionalBits;

    x = zeros(size(r,1),1);
    
    [M,N] = size(A);
    Lc = 2/Nv;
    Lc = toFixedpointInteger(Lc, fractionalBits);
    r = toFixedpointInteger(r, fractionalBits);
    lam = Lc*r;
    lam= shiftInRange(lam, fractionalBits);
    lam = saturateInteger(lam, fractionalBits, worldLength);

    lambda = lam;
    messageBit2Check= zeros(M, N);
    messageCheck2Bit= zeros(M, N);
    %messageBit2checktanh= spalloc(M, N, nzero);
%     messageCheck=zeros(M,1);
    a = toFixedpointInteger(a, fractionalBits);

       
    for iteration=1:L
      
     % Bit-to-check messages

     messageBit2Check(inL) = lambda(inB) - messageCheck2Bit(inL) ;          %sum of var and check node messages -{i}

         
     % Check-to-bit messages

     for i = 1:M
        bit = find(A(i,:));
        in_mssgs = messageBit2Check(i, bit);
        for k = 1:length(bit)
            minBeta = realmax;
%             integerBits = worldLength - fractionalBits;
%             minBeta = (2^integerBits-2^-fractionalBits);
            minBeta = saturate(minBeta, fractionalBits, worldLength);
            minBeta = toFixedpointInteger(minBeta, fractionalBits);
            Lb = in_mssgs(bit~=bit(k));
            for l = 1:length(Lb)
                minBeta = min(minBeta, abs(Lb(l)));
            end
            messageCheck2Bit(i,bit(k)) = a * prod(sign(Lb))*minBeta;
            messageCheck2Bit(i,bit(k)) = shiftInRange(messageCheck2Bit(i,bit(k)), fractionalBits);
            messageCheck2Bit(i,bit(k)) = saturateInteger(messageCheck2Bit(i,bit(k)), fractionalBits, worldLength);

        end
     end
     
    % Bit messages (LLR total)
     lambda = sum(messageCheck2Bit, 1).' + lam;
    % Hard decision
     x = lambda <= 0;

     %exit or continue                                   
     z1 = mod(A*x,2);  
     if(all(double(z1==0)) )         % compute decoded bits for stopping criterion
         break; 
     end
    end