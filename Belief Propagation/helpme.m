function [result] = helpme(a,b) 
result = log((exp(a)+exp(b))/(1+exp(a+b)));
