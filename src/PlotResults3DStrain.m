function [] = PlotResults3DStrain(DAT)
fg70 = figure(70);
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



ax = subplot(2,3,2);
plotAll_Mohr(ax,DAT.sigma123,'')

subplot(2,3,3)
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

subplot(2,3,1)
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
legend(hp,'Coulumb','Resulted planes','Orthorhombic planes','location','northeast')



subplot(2,3,5)
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

subplot(2,3,4)
fpower = fit(S1, DAT.w,'b*x^m','StartPoint',[1e-04,2]);
x = linspace(min(S1), max(S1),20);
hold on
hp(1) = scatter(S1,DAT.w,30,'filled','g');
hp(2) = scatter(S1,DAT.W,30,'filled','m');
hp(3) = plot(x, fpower.b.*x.^fpower.m,'linewidth',2);
txt_powr = ['Power Fit: y = ',num2str(fpower.b,3),' X^{',num2str(fpower.m,3),'}'];

legend(hp,'Elastic Energy','Interal Energy',txt_powr,'location','northwest')
box on
grid on
axis square
% xlabel('Normal stress (MPa)')
xlabel('\sigma1 (MPa)')
ylabel('Energy (MJ/m^3)')


AddLetters2Plots(fg70, 'HShift', 0, 'VShift', 0, 'Direction', 'LeftRight')
supertitle1(DAT.name)

end