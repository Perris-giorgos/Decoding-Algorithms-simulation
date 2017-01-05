function [fixedOut] = shiftInRange(a, fbits)
    fixedOut = a/2^fbits;