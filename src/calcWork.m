function W = calcWork(Sigma123, N, Ds, k, Dd)
N3 = calcN3(N(1),N(2));
SigN = Sigma123(:,1).*N(:,1).^2+Sigma123(:,2).*N(:,2).^2+Sigma123(:,3).*N3.^2; % (Z)
S = N2S(N,k);
% calc work
slipA = sqrt(Ds(1)^2 + Ds(2)^2 + Ds(3)^2); % Slip amount (BI) - check ok!
SnS = -sum([N,N3].*S.*Sigma123); % Shear in slip (AD or BR)  - check ok!
sWork = slipA * SnS; % BJ - check ok!
dWork = Dd(1) * SigN; % BL - check ok!
W = sum([sWork, dWork]); % BM - check ok!
end