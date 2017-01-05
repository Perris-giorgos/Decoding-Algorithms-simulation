function [fixedOut] = saturateInteger(a, fbits, wL)
    i = wL - fbits;
    
    scale = 2^fbits;
    
    range1 = -2^(i) ;
    range1 = floor(range1*(2^fbits));
    range2 = (2^i-2^-fbits) ;
    range2 = floor(range2*(2^fbits));

    if a > range2
        fixedOut = range2;
    elseif a < range1
        fixedOut = range1;
    else
        fixedOut = a;
    end