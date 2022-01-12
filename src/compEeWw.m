function res = compEeWw(inputs,e,sigma123, w)
N = inputs(1:2);
Ds = inputs(3:5);
Dd = inputs(6);
k = e(2) / e(1);
W = calcWork(sigma123, N, Ds,k,Dd);
E = calcE(N,Ds,Dd,k);


res(1:3) = E;
res(4) = sum(E./e);
res(5) = 1*std(E./e);
res(6) = W/w;
% res(7) = Dd / sqrt(sum(Ds.^2));
end