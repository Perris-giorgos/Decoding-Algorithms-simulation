function [x, iteration] = Belief_propagation_lambda_min_offset_correction1(A, r, L, Nv, codeRate, Eb, inC, inB, inL) 

    % A = parity check matrix
    % r = received signal vector
    % L = number of iterations
    % Nv= noisevariance
    % Lc= channel reliability
    % [inC,inB]=find(A)
    % inL=find(A)
    % nzero= non zero elements
    
    %�?Min Decoding Algorithm of Regular and Irregular LDPC Codes
    %0.3 good
    
    l_min = 3;
    offset = 0.3;
    
    x = zeros(size(r,1),1);
    
    [M,N] = size(A);
    if Nv~=0
        Lc = -2/Nv;        
    else 
        Lc = -1;
    end
    
    lam = Lc*r;                                                            % Ln for 0 iteration         
    lambda = lam;                                                          % Zn for i iteration
    
    messageBit2Check = zeros(M, N);                                        % Zmn for i iteration :info sent from Um to Cn
    messageCheck2Bit = zeros(M, N);                                        % Lmn for i iteration :info sent from Cm to Un
    prodOfB2C = zeros(M,1);
    Dividend = zeros(M, N); 
    Divisor = zeros(M, N); 
%     sumDividend = zeros(M,1);
    sumDivisor = zeros(M,1);
    Smn = zeros(M, N); 
    Mmn = zeros(M, N);
    
    for iteration=1:L
        
        messageBit2Check(inL) = lambda(inB) - messageCheck2Bit(inL) ;     
        
        for iCheck = 1:M
            K= A(iCheck,:)~=0;
            prodOfB2C(iCheck) = prod(sign(-messageBit2Check(iCheck, K)));
        end

        Smn(inL) = sign(messageBit2Check(inL)) .* prodOfB2C(inC) ;

        for iCheck = 1:M
            bit = find(A(iCheck,:));
            in_mssgs = messageBit2Check(iCheck, bit);
            LbSorted = sort((abs(in_mssgs)));
            l_minimum(1:l_min) = LbSorted(1:l_min);
%              l_minimum = LbSorted;
            for k = 1:length(bit)
                newmssgs = l_minimum(1:l_min);
                if (any(l_minimum == (abs(in_mssgs(k)))))
                    newmssgs = setdiff(l_minimum, abs(in_mssgs(k)));
                    tempor = fun(-newmssgs(1),-newmssgs(2));
                else
                    tempor = fun(-newmssgs(1),-newmssgs(2));
                    tempor = fun(tempor,-newmssgs(3));

                end
                Mmn(iCheck, bit(k)) = -tempor;
            
            end

        end
 
        %Divisor(inL) = exp(sumDivisor(inL));

      %  Mmn(A~=0) = -log(Dividend(A~=0) ./ (1+Divisor(A~=0)));

        messageCheck2Bit = Smn .* max(Mmn-offset,0);
        
        % Bit messages (LLR total)
        lambda = sum(messageCheck2Bit, 1).' + lam;                             % Z(i)n = L(0)n +SUMm2M(n) L(i)mn         

        % Hard decision
        x = lambda >= 0;   
        
             %exit or continue                                   
        z1 = mod(A*x,2);                                                      % si(x) = H*x'

        if(all(double(z1==0)) )         % compute decoded bits for stopping criterion
             break; 
        end    
    end