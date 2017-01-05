function [min3approx] = TESTApproxmin3(x)

if x(1) < x(2)
    min1 = x(1);
else
    min1 = x(2);
end

if x(3) < x(4)
    min2 = x(3);
else
    min2 = x(4);
end

if x(5) < x(6)
    min3 = x(5);
else
    min3 = x(6);
end

if x(7) < x(8)
    min4 = x(7);
else
    min4 = x(8);
end

if min1 < min2
    MIN1 = min1;
    max1 = min2;
else
    MIN1 = min2;
    max1 = min1;
end

if min3 < min4
    MIN2 = min3;
    max2 = min4;
else
    MIN2 = min4;
    max2 = min3;
end

if max1 < max2 
    MIN3 = max1;
else
    MIN3 = max2;
end
min3approx = [MIN1 MIN2 MIN3];