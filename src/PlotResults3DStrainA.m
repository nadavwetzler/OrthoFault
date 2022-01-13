function PlotResults3DStrainA(DAT,ip)

fg10 = figure(10);
[fit1,fit1S] = polyfit(DAT.SigN, DAT.SnS,1);

S1 = zeros(size(DAT.sigma123,1),1);
S2 = zeros(size(DAT.sigma123,1),1);
S3 = zeros(size(DAT.sigma123,1),1);
for ii=1:size(DAT.sigma123,1)
    sv = sort(DAT.sigma123(ii,:),'descend');
    S1(ii) = sv(1);
    S2(ii) = sv(3);
    S3(ii) = sv(3);
end

fitCC = polyfit(S3,S1,1);
psi = atand(fitCC(1));
theta = asin((fitCC(1) - 1) / (fitCC(1) + 1 ));
C0 = (fitCC(2) * (1-sin(theta))) / (2 * cos(theta));
dipdir = make360(DAT.Strike + 90);

for ii=1:size(DAT.sigma123,1)
    sv = sort(DAT.sigma123(ii,:),'descend');
    S1(ii) = sv(1);
    S2(ii) = sv(3);
    S3(ii) = sv(3);
end

fitCC = polyfit(S3,S1,1);
theta = asin((fitCC(1) - 1) / (fitCC(1) + 1 ));


 
if ip > length(DAT.Rake)
    disp('the selected plane is not in list, please decrease id number')
    ip = round(mean(1:length(DAT.Rake)));
    disp(['Selecting random plane (',num2str(ip),')']);
end
%% A
axA = subplot(4,4,[1,5]);
dipC1 = 45 + rad2deg(theta)/2;
stereonetplot(DAT.Strike+180, DAT.Dip, DAT.Rake, 'c','b');
stereonetplot(-DAT.Strike, DAT.Dip, -DAT.Rake, 'c','b');
stereonetplot(-DAT.Strike+180, DAT.Dip, -DAT.Rake, 'c','b');
stereonetplot(DAT.Strike, DAT.Dip, DAT.Rake, 'k','r');
stereonetplot(180, dipC1, 90, 'b','k');
stereonetplot(0, dipC1, 90, 'b','k');

hp(1) = plot(NaN,NaN,'-k');
hp(2) = plot(NaN,NaN,'-r');
hp(3) = plot(NaN,NaN,'-b');
legend(hp,'Coulumb conjugate set','Preferred faults with slip axes','Orthorhombic faults','location','northeast')

%% B
axB = subplot(4,4,[2,6]);
fpower = fit(S1, DAT.w,'b*x^m','StartPoint',[1e-04,2]);
x = linspace(min(S1), max(S1),20);
hold on
hp(1) = scatter(S1,DAT.w,30,'filled','g');
hp(2) = scatter(S1,DAT.W,30,'filled','m');
hp(3) = plot(x, fpower.b.*x.^fpower.m,'linewidth',2);
txt_powr = ['Power Fit: y = ',num2str(fpower.b,3),' X^{',num2str(fpower.m,3),'}'];

legend(hp,'Applied elastic energy','Dissipated energy',txt_powr,'location','northwest')
box on
grid on
axis square
% xlabel('Normal stress (MPa)')
xlabel('\sigma1 (MPa)')
ylabel('Energy (MJ/m^3)')
%% C
axC = subplot(4,4,[3,7]);
hold on
x = linspace(0, max(DAT.SigN),20);

scatter(DAT.SigN, DAT.SnS,'r');
% plot fit
lin1 = plot(x,fit1(1)*x+fit1(2),'-r','linewidth',2);
txt_lin1 = ['Present theory: Y = ',num2str(fit1(1),3),' X + ',num2str(fit1(2),3)];

% plot Coulomb
linCC = plot(x, tan(theta).*x + C0,'-k','linewidth',2);
txt_linCC = ['Coulomb criterion: Y = ',num2str(tan(theta),3),'  X + ',num2str(C0,3)];

legend([lin1, linCC],txt_lin1,txt_linCC)%,'95% Prediction Interval', 'location','northwest')
box on
grid on
axis square
xlabel('Normal stress (MPa)')
ylabel('Shear stress (MPa)')
%legend(lin1, ['Slope: ',num2str(fit1(1),1)])


%% D
axD = subplot(4,4,[4,8]);
plotAll_Mohr(axD,DAT.sigma123,'')

%% E
axE = subplot(4,4,[9,13]);
stereonetplot(DAT.Strike, DAT.Dip, DAT.Rake, 'k');
stereoplot1(dipdir(ip)+180, DAT.Dip(ip), DAT.Rake(ip),'b','b','--','m')
stereoplot1(-dipdir(ip), DAT.Dip(ip), -DAT.Rake(ip),'b','b','--','m')
stereoplot1(-dipdir(ip)+180, DAT.Dip(ip), -DAT.Rake(ip),'b','b','--','m')
stereoplot1(dipdir(ip), DAT.Dip(ip), DAT.Rake(ip), 'b','b','-','m');
dipC = 45 + rad2deg(theta)/2;
stereoplot1(90, dipC, 90, 'b','k');

hp(1) = plot(NaN,NaN,'-k'); % 
hp(2) = plot(NaN,NaN,'-r');
hp(3) = plot(NaN,NaN,'-b');
hp(4) = plot(NaN,NaN,'--b');
hp(5) = plot(NaN,NaN,'-m');
legend(hp(1:4),'Coulumb criterion fault','Preferred faults with slip axes','Selected fault','Selected fault in orthorhombic pattern','location','southoutside')

%% F
axF = subplot(4,4,[10,14]);
plotBoxOrthorombic(DAT.Strike(ip), DAT.Dip(ip), DAT.e(ip,:))
title(['Experiment #',num2str(ip)])
%% G
axG = subplot(4,4,11);
plotMohrC(DAT.e(ip,:))
xlabel('Normal Strain','fontsize',12)
ylabel('Shear Strain','fontsize',12)
e = sort(DAT.e(ip,:),'descend');
text(e(1),-0.1*abs(e(1)),'\epsilon_1','Color','r','FontSize',14)
text(e(2),-0.1*abs(e(1)),'\epsilon_2','Color','g','FontSize',14)
text(e(3),-0.1*abs(e(1)),'\epsilon_3','Color','b','FontSize',14)
title(['Experiment #',num2str(ip)])
%% H
axH = subplot(4,4,15);
plotMohrC(DAT.sigma123(ip,:))
xlabel('Normal Stress (MPa)','fontsize',12)
ylabel('Shear Stress (MPa)','fontsize',12)
%% I
axI = subplot(4,4,[12,16]);
hold on
lineCC = linspace(min(S3),max(S3),20);
hold on
scatter(S3,S1,'filled')
p1 = plot(lineCC, fitCC(1).*lineCC + fitCC(2));
xlabel('\sigma3 (MPa)')
ylabel('\sigma1 (MPa)')
legend(p1,['y=',num2str(fitCC(1),3),'X + ',num2str(fitCC(2),3), '  \psi=',num2str(psi,2)])
box on
grid on
axis square
%%

AddLetters2Plots({axA, axB, axC, axD, axE, axF, axG, axH, axI}, 'HShift', 0, 'VShift', 0, 'Direction', 'LeftRight')
supertitle1(DAT.name)
end
