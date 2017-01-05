function [result] = helpme1(a,b) 
result = -sign(a)*sign(b)*min(abs(a),abs(b))+log(1+exp(-abs(a-b)))-log(1+exp(-abs(a+b)));
