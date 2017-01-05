function [fixedOut] = toFixedpointInteger(a, fbits)
    fixedOut = floor(a*(2^fbits));