function [fixedOut] = tofixedpointfractional(a, fbits)
    fixedOut = a/2^fbits;