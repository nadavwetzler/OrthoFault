clc
clear
close all


[filepath,~,~] = fileparts(which('run_3D_strain.m'));
cd(filepath)
cd('../data')

%% Parameters and data

YM = 11500; % Young's modulus
PM = 0.38; % Poisson modulus
[G, Lambda] = calcModulus(PM,YM);
% filename = 'KTB-amphibolite'; de = 0.1;
filename = 'Shirahama-sandstone'; de = 0.1;
% filename = 'Solenhofen-limestone'; de = 0.1;
% filename = 'Dunham-dolomite'; de = 0.01;
% filename = 'Yuubari-shale'; de = 0.1;

% load dislocation data
load Dshear
load Ddilat

%load stress data
[sigma123, Ddilat,Dshear] = LoadSigma(filename, Ddilat, Dshear);
%%
% Invariants
[I1_2E, SQRT_J2, I2_2] = calcInvariants(sigma123,PM,YM);

% elastic starins
e = calcEstrain(sigma123, PM,YM);

% elastic starin energy
[J1, J2, MJm3] = calcEnergyS(sigma123, YM,PM);
k = e(:,2) ./ e(:,1);

Sig123 = abs(Ddilat./Dshear);
%% find N from input dislocation and k compared with elastic strain
N = zeros(size(sigma123,1),3);
de0 = zeros(size(sigma123,1),1);
for ii =1:size(sigma123,1)
    [N(ii,:), de0(ii)] = calcN(Dshear(ii,:), Ddilat(ii,:), k(ii), e(ii,:),de);
end

%% remove bad results
I        = N(:,1) ~= -999;
N        = N(I,:);
Dshear   = Dshear(I,:);
Ddilat   = Ddilat(I,:);
sigma123 = sigma123(I,:);
Sig123   = Sig123(I,:);
k        = k(I);
e        = e(I,:);
de0      = de0(I);
%% convert results
% E = calcE(N,Dshear, Ddilat,k)
S = N2S(N, k);
[SigN, MaxS] = calc_SIGN_MaxS(sigma123, N);
[fit1,fit1S] = polyfit(SigN, MaxS,1);
[y_fit1,delta1] = polyval(fit1,SigN,fit1S);
[Dip, DipDir, SlipPlu,Slip_Tre] = Orientation2fault(S,N);
[ Strike,Dip,Rake] = DDRPT2SDR( Dip, DipDir , SlipPlu, Slip_Tre );


%% Plots
figure(1)
subplot(2,2,1)
plotSigma123(sigma123, Sig123)


subplot(2,2,2)
hold on
scatter(k, Slip_Tre)
scatter(k, DipDir)
legend('Slip-Tred','Dip-Direction')
xlabel('k')
box on
grid on
axis square

subplot(2,2,3)
hold on
scatter(SigN, MaxS)
lin1 = plot(SigN,fit1(1)*SigN+fit1(2),'linewidth',2);
plot(SigN,y_fit1+2*delta1,'k:',SigN,y_fit1-2*delta1,'k:')
legend('Data',['Linear Fit - Slope: ',num2str(fit1(1),1)],'95% Prediction Interval', 'location','northwest')
box on
grid on
axis square
xlabel('Normal sterss')
ylabel('Shear stress')
%legend(lin1, ['Slope: ',num2str(fit1(1),1)])


subplot(2,2,4)
stereonetplot(Strike, Dip, Rake)
supertitle(filename)
clear('N')



%% Functions
function [G, Lambda] = calcModulus(PM,YM)
G  = YM / (2*(1+PM));
Lambda = (YM * PM) / ((1+PM)*(1 - 2*PM));
end

function e = calcEstrain(sigma123,PM,YM)
e = zeros(size(sigma123,1),3);
e(:,1) = (sigma123(:,1) - PM*(sigma123(:,2) + sigma123(:,3))) ./ YM;
e(:,2) = (sigma123(:,2) - PM*(sigma123(:,1) + sigma123(:,3))) ./ YM;
e(:,3) = (sigma123(:,3) - PM*(sigma123(:,2) + sigma123(:,1))) ./ YM;
end

function [I1_2E, SQRT_J2, I2_2] = calcInvariants(sigma123,PM,YM)
I1 = sum(sigma123,2);
I1_2E = I1.^2/(2*YM);
SQRT_J2 = sqrt(((sigma123(:,1) - sigma123(:,3)).^2 + (sigma123(:,1) - sigma123(:,2)).^2 + (sigma123(:,2) - sigma123(:,3)).^2)/6);
I2_2 = -(2*(1+PM))*(sigma123(:,1).*sigma123(:,2) + sigma123(:,2).*sigma123(:,3) + sigma123(:,1).*sigma123(:,3))/(2*YM);
end

function [J1, J2, MJm3] = calcEnergyS(sigma123, YM,PM)
J1 = 0.5 * (sum(sigma123.^2,2)) / YM;
J2 = 0.5*((-2.0*PM*(sigma123(:,2).*sigma123(:,3)+sigma123(:,3).*sigma123(:,1)+sigma123(:,1).*sigma123(:,2))) / YM);
MJm3 = 0.5*(sum(sigma123.^2,2)-2*PM*(sigma123(:,2).*sigma123(:,3)+sigma123(:,3).*sigma123(:,1)+sigma123(:,1).*sigma123(:,2)))/YM;
end

function S = N2S(N, k)
S(:,1) = -sqrt((1-N(:,1).^2-N(:,2).^2)./(1-N(:,2).^2+(N(:,1).^2).*((((k.^2) .* (1-N(:,1).^2))./N(:,2).^2)+2.*k)));
S(:,2) = (S(:,1).*N(:,1).*k./N(:,2));
S(:,3) = -sqrt(1-S(:,1).^2-S(:,2).^2);
end

function [E] = calcEideal(N,S,Ds, Dd)
E(1) = N(1)*Dd(1)*Ds(1) - S(1)*Ds(1);
E(2) = N(2)*Dd(2)*Ds(2) + S(2)*Ds(2);
E(3) = N(3)*Dd(3)*Ds(3) + S(3)*Ds(3);
end


function [SigN, MaxS] = calc_SIGN_MaxS(sigma123, N)
SigN = sigma123(:,1).*N(:,1).^2+sigma123(:,2).*N(:,2).^2+sigma123(:,3).*N(:,3).^2;
MaxS = sqrt((sigma123(:,1)-sigma123(:,2)).^2.*N(:,1).^2.*N(:,2).^2+(sigma123(:,2)-sigma123(:,3)).^2.*N(:,2).^2.*N(:,3).^2+(sigma123(:,3)-sigma123(:,1)).^2.*N(:,1).^2.*N(:,3).^2);
end

function [Dip, DipDir, SlipPlu,Slip_Tre] = Orientation2fault(S,N)
Dip = acosd(N(:,1));
DipDir = atand(N(:,3)./N(:,2))+180;
SlipPlu = -asind(S(:,1));
Slip_Tre = zeros(length(SlipPlu),1);
I =  (S(:,3)./S(:,2)) > 0;
Slip_Tre(I) = atand(S(I,3)./S(I,2));
Slip_Tre(~I) = atand(S(~I,3)./S(~I,2)) + 180;

% f = (N(:,3).^2 + N(:,1).^2).^0.5;
% e = (N(:,1).^2 + f.^2).^0.5;
% Rake = round(make360(360 - asind(f./e)));
end

function [] = plotSigma123(sigma123, Sig123)
hold on
scatter(sigma123(:,1),Sig123(:,1),'r')
scatter(sigma123(:,2),Sig123(:,2),'m')
scatter(sigma123(:,3),Sig123(:,3),'b')
title('Dilation/slip ratio vs corresponding principal stresses')
legend('\sigma_1','\sigma_2','\sigma_3')
xlabel('Stress [MPa]')
box on
grid on
axis square
end

function [sigma123, Ddilat,Dshear] = LoadSigma(filename, Ddilat, Dshear)
sigma123 = importSigma123_file(filename);
sigma123 = sortrows(sigma123,1);
if size(sigma123,1) > size(Ddilat,1)
    sigma123 = sigma123(1:size(Ddilat,1),:);
    disp('Adapting size of Sigma!!')
else
    Ddilat = Ddilat(1:size(sigma123,1),:);
    Dshear = Dshear(1:size(sigma123,1),:);
    disp('Adapting size of Ddilat!!')
end

end


function [N,de0] = calcN(Dshear, Ddilat, k, e, de)
de0 = de;
N_guess = [de0, de0];
fun = @(N)calcE(N,Dshear(1:2), Ddilat(1:2),k)-e(1:2);
n = round(10 / de);
if n < 10
    n = 10;
end
% opts1=  optimset('display','off');
N = zeros(n,3);
for ii=1:n
    N = lsqnonlin(fun,N_guess);
    N(3) = -sqrt(1 - N(1)^2 - N(2)^2);
    if isreal(N)
        break
    else
        de0 = de0 + de;
        N_guess = [de0, de0];
        N = [-999, -999, -999];
    end
end


end



