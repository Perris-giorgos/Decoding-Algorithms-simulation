function [x] = ldpcsoft5_kalo(A, r, L, Nv, codeRate, Eb, inC, inB, inL, nzero) 
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
    if Nv~=0
        Lc = -2*sqrt(codeRate*Eb)/Nv;        
    else 
        Lc = -1;
    end
    lam = Lc*r;
    lambda = lam;
    messageBit2Check= spalloc(M, N, nzero);
    messageCheck2Bit= spalloc(M, N, nzero);
    %messageBit2checktanh= spalloc(M, N, nzero);
    messageCheck=zeros(M,1);
    iterations=0;
   
    for iteration=1:L
      %fprintf(1,'iteration #%d\n',iteration);    
      
     % Bit-to-check messages
     messageBit2Check(inL) =  messageCheck2Bit(inL) - lambda(inB);
     % Check-to-bit messages
     messageBit2checktanh1 = messageBit2Check / 2;
     messageBit2checktanh = tanh(messageBit2checktanh1);
     
    for iCheck = 1:M
           K=find(A(iCheck,:));
           messageCheck(iCheck) = prod( messageBit2checktanh(iCheck, K));
    end 
    
    messageCheck2Bit(inL) = -2 * atanh(messageCheck(inC)./messageBit2checktanh(inL));
    
    % Bit messages
     lambda = sum(messageCheck2Bit, 1).' + lam;
      
    % Hard decision
     x = lambda >= 0;
     
     %exit or continue                                   
     z1 = mod(A*x,2);  
     if(all(double(z1==0)) )         % compute decoded bits for stopping criterion
         break; 
     end
    end
