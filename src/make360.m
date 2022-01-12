function [x1] = make360(x)
n1= length(x);
x1(1:n1) = 0;
for ii=1:n1
    check = 0;
    if (x(ii) < 0)
        x1(ii) = 360 + x(ii);
        check = 1;
    end
    if (x(ii) > 360)
        x1(ii) = x(ii) - 360;
        check = 1;
    end
    if (x1(ii) < 0)
        x1(ii) = 360 + x1(ii);
        check = 1;
    end
    if (x1(ii) > 360)
        x1(ii) = x1(ii) - 360;
        check = 1;
    end
    if check ==0
        x1(ii) = x(ii);
    end
        
end

end

