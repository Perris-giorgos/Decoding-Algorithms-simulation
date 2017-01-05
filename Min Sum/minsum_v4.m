function [x ,iteration] = minsum_v4(A, r, L, Nv, inB, inL) 
    % A = parity check matrix
    % r = received signal vector
    % L = number of iterations
    % Nv= noisevariance
    % Lc= channel reliability
    % [inC,inB]=find(A)
    % inL=find(A)
    % nzero= non zero elements
    
    x = zeros(size(r,1),1);
    
    [M,N] = size(A);
    Lc = 2/Nv;
    lam = Lc*r;
    lambda = lam;
    messageBit2Check= zeros(M, N);
    messageCheck2Bit= zeros(M, N);
    %messageBit2checktanh= spalloc(M, N, nzero);
%     messageCheck=zeros(M,1);
   
    for iteration=1:L
      %fprintf(1,'iteration #%d\n',iteration);    
      
     % Bit-to-check messages

     messageBit2Check(inL) = lambda(inB) - messageCheck2Bit(inL) ;          %sum of var and check node messages -{i}

%     length(find(messageBit2Check>31))

    % Check-to-bit messages

     for i = 1:M
        bit = find(A(i,:));
        in_mssgs = messageBit2Check(i, bit);
        for k = 1:length(bit)
            minBeta = realmax;
            Lb = in_mssgs(bit~=bit(k));
            for l = 1:length(Lb)
                minBeta = min(minBeta, abs(Lb(l)));
            end
            messageCheck2Bit(i,bit(k)) = prod(sign(Lb))*minBeta;
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
