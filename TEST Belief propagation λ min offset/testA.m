notsame = 0;
same = 0;
correct_v2 = 0;
wrong_v2 = 0;
wrong_v1 = 0;
correct_v1 = 0;
correct2 = 0;
correct1 = 0;
correct3=0;
correct0=0;
sameandcorrect = 0;
for i=1:100000000
    testnum = randi([-10000 10000], 8 , 1);
    x = TESTApproxmin3_v2(testnum);
    y = TESTApproxmin3(testnum);
    z = sort(testnum);
    if any(sort(x) ~= sort(y))
        notsame= notsame + 1;
    elseif all(sort(x) == sort(y))
        same = same + 1;
    end
    if any(sort(x)~=z(1:3)')
        wrong_v2 = wrong_v2 + 1;
    elseif all(sort(x) == z(1:3)')
        correct_v2 = correct_v2 + 1;
    end
    if any(sort(y)~=z(1:3)')
        wrong_v1 = wrong_v1 + 1;
    elseif all(sort(y) == z(1:3)')
        correct_v1 = correct_v1 + 1;
    end
    if all(sort(x) == sort(y))
        if all(sort(y) == z(1:3)')
            sameandcorrect = sameandcorrect +1;
        end
    end
%     if (any(z(1:3)==a(1)) && any(z(1:3) == a(2)) && any((1:3) ~= a(3)))||(any(z(1:3)==a(1)) && any(z(1:3) == a(3)) && any(z(1:3) ~= a(2)))||(any(z(1:3)==a(3)) && any(z(1:3) == a(2)) && any(z(1:3) ~= a(1)))
%         correct2 = correct2+1;
%     end
    tc(1) = any(z(1:3)==y(1));
    tc(2) = any(z(1:3)==y(2));
    tc(3) = any(z(1:3)==y(3));
    t=length(find(tc)==1);
    if t==1
        correct1 = correct1+1;
    elseif t==0
        correct0=correct0+1;
    elseif t==2&&t~=3
        correct2 = correct2+1;
    elseif t==3
        correct3=correct3+1;
    end        
     
end