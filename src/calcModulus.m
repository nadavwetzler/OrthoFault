function [G, Lambda] = calcModulus(PM,YM)
G  = YM / (2*(1+PM));
Lambda = (YM * PM) / ((1+PM)*(1 - 2*PM));
end
