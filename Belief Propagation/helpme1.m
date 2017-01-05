function [result] = helpme1(a,b) 
result = -min(a,b)+log(1+exp(-abs(a-b)))-log(1+exp(-abs(a+b)));
