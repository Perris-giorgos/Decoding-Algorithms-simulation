function [min3approx] = TESTApproxmin3_v2(x)
%%
if x(1) < x(2)
    min1 = x(1);
    max1 = x(2);
else
    min1 = x(2);
    max1 = x(1);
end

if max1 < x(3)
    min2 = max1;
    max2 = x(3);
else
    min2 = x(3);
    max2 = max1;
end

if max2 < x(4)
    min3 = max2;
    max3 = x(4);
else
    min3 = x(4);
    max3 = max2;
end

%%
if min1 < min2 
    MIN1_1 = min1;
    max4 = min2;
else
    MIN1_1 = min2;
    max4 = min1;
end

if max4 < min3 
    MIN1_2 = max4;
else
    MIN1_2 = min3;
end

%%
if x(5) < x(6)
    min5 = x(5);
    max5 = x(6);
else
    min5 = x(6);
    max5 = x(5);
end

if max5 < x(7)
    min6 = max5;
    max6 = x(7);
else
    min6 = x(7);
    max6 = max5;
end

if max6 < x(8)
    min7 = max6;
    max7 = x(8);
else
    min7 = x(8);
    max7 = max6;
end

%%
if min5 < min6 
    MIN2_1 = min5;
    max8 = min6;
else
    MIN2_1 = min6;
    max8 = min5;
end

if max8 < min7 
    MIN2_2 = max8;
else
    MIN2_2 = min7;
end
 %%
if MIN1_1 < MIN1_2
    MIN1 = MIN1_1;
    MAX1 = MIN1_2;
else
    MIN1 = MIN1_2;
    MAX1 = MIN1_1;
end

if MIN2_1 < MIN2_2
    MIN2 = MIN2_1;
    MAX2 = MIN2_2;
else
    MIN2 = MIN2_2;
    MAX2 = MIN2_1;
end

%%
if MAX1 <MAX2 
    MIN3 = MAX1;
else
    MIN3 = MAX2;
end

min3approx = [MIN1 MIN2 MIN3];