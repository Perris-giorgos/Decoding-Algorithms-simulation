function [x] = ldpcsoft5_fixed_point_ready(A, r, L, Nv, codeRate, Eb, inC, inB, inL) 
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
    messageBit2Check= zeros(M, N);
    messageCheck2Bit= zeros(M, N);
    messageBit2checktanh= zeros(M, N);
    messageCheck=zeros(M,1);
    it=0;
    for iteration=1:L
        it = it + 1  ;  

         % Bit-to-check messages
         messageBit2Check(inL) =  messageCheck2Bit(inL) - lambda(inB);
         % Check-to-bit messages
         messageBit2checktanh1 = messageBit2Check / 2;

         for l=1:length(inL)
            messageBit2checktanh(inL(l)) = tanh(messageBit2checktanh1(inL(l)));
         end

         for iCheck = 1:M
               K=find(A(iCheck,:));
               product = 1;
               for l=1:length(K)
                    product = messageBit2checktanh(iCheck, K(l))*product;
               end
               messageCheck(iCheck) = product;
         end 

         for l=1:length(inL)
             messageCheck2Bit(inL(l)) = -2 * atanh(messageCheck(inC(l))/messageBit2checktanh(inL(l)));
         end

        % Bit messages
         lambda = sum(messageCheck2Bit, 1).' + lam;

        % Hard decision
%          x = lambda >= 0;
         for i=1:648
            if lambda(i)>=0
                x(i) = 1;
            else 
                x(i) = 0;
            end
         end

         %exit or continue                                   
         z1 = mod((A)*(x),2);  
         if(all(z1==0))          % compute decoded bits for stopping criterion
             break; 
         end
    end