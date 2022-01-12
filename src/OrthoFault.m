function [DAT] = OrthoFault(DAT,PM,YM)
N1_range = 0.02:0.05:0.6;
N2_range = 0.02:0.05:0.6;

[DAT.G, DAT.Lambda] = calcModulus(PM,YM);

% Invariants
[I1_2E, SQRT_J2, I2_2] = calcInvariants(DAT.sigma123,PM,YM);

% elastic starins J:L
e = calcEstrain(DAT.sigma123, PM,YM);

% elastic starin energy M:O
[J1, J2, w] = calcEnergyS(DAT.sigma123, YM,PM); 
k = e(:,2) ./ e(:,1);

%% find N from input dislocation and k compared with elastic strain
N  = zeros(size(DAT.sigma123,1),3);
Ng1  = zeros(size(DAT.sigma123,1),1);
Ng2  = zeros(size(DAT.sigma123,1),1);
Ds = zeros(size(DAT.sigma123,1),3);
Dd = zeros(size(DAT.sigma123,1),1);
W  = zeros(size(DAT.sigma123,1),1);
slipAM = zeros(length(N1_range),length(N1_range),size(DAT.sigma123,1));
parfor ii =1:size(DAT.sigma123,1)
    disp([num2str(ii),'/',num2str(size(DAT.sigma123,1))])
    slipA = zeros(length(N1_range),length(N1_range));
    % Grid search!
    for in1 = 1:length(N1_range)
        for in2 = 1:length(N2_range)
            guess = [N1_range(in1), N2_range(in2), 0.01, 0.01, 0.01, 0.01];
            [~,Dst,~,~]= calcN5(e(ii,:),guess,DAT.sigma123(ii,:),w(ii));
            slipA(in1, in2) = sqrt(Dst(1)^2 + Dst(2)^2 + Dst(3)^2); % Slip amount (BI) - check ok!

        end
    end
    slipAM(:,:,ii) = slipA;
    minMatrix = min(slipA(:));
    [row,col] = find(slipA==minMatrix);
    Ng1(ii) = N1_range(col);
    Ng2(ii) = N2_range(row);

    %% Run again with best N1 and N2
    
    guess = [N1_range(col), N2_range(row), 0.01, 0.01, 0.01, 0.01];
    [N(ii,:),Ds(ii,:),Dd(ii),W(ii)]= calcN5(e(ii,:),guess,DAT.sigma123(ii,:),w(ii));
    %%
end     
[SigN, MaxS] = calc_SIGN_MaxS(DAT.sigma123, N);
S = N2S(N, k);
SnS = -sum(N.*S.*DAT.sigma123,2); % Shear in slip (AD or BR)  - check ok!
DAT.N = N;
DAT.Ds = Ds;
DAT.Dd = Dd;
DAT.W = W;
DAT.w = w;
DAT.k = k;
DAT.e = e;
DAT.S = S;
DAT.SnS = SnS;
DAT.slipAM = slipAM;
DAT.Ng1 = Ng1;
DAT.Ng2 = Ng2;
DAT.SigN = SigN;
DAT.MaxS = MaxS;

[DAT.Dip, DAT.DipDir, DAT.SlipPlu,DAT.Slip_Tre] = Orientation2fault(S,N);
[ DAT.Strike,DAT.Dip,DAT.Rake] = DDRPT2SDR( DAT.Dip, DAT.DipDir , DAT.SlipPlu, DAT.Slip_Tre );
end