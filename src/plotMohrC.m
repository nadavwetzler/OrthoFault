
function [] = plotMohrC(sig0,fit1)
% sig = sort(abs(sig0),'descend');
sig = sort((sig0),'descend');
ang = 0:1:360;
fz = 12;
% Big Circle
R(1) = (sig(1)-sig(3))/2;
C(1) = (sig(1) + sig(3))/2;

% Small 1-2 Circle
R(2) = (sig(1)-sig(2))/2;
C(2) = (sig(1) + sig(2))/2;

% Small 3-2 Circle
R(3) = (sig(2)-sig(3))/2;
C(3) = (sig(3) + sig(2))/2;

for jj=1:3
    for ii=1:length(ang)
        Tau(ii,jj) = R(jj)*sind(2*ang(ii));
        N(ii,jj) = C(jj) + R(jj)*cosd(2*ang(ii));
    end
end
hold on
plot(N(:,1),Tau(:,1),'-k')
plot(N(:,2),Tau(:,2),'-k')
plot(N(:,3),Tau(:,3),'-k')

if nargin == 2
    line_mue = linspace(0,sig(1));
    plot(line_mue,line_mue*fit1(1)+fit1(2),'-k','Linewidth',1)
end

dx = 0.1*(max(N(:,1)) - min(N(:,1)));
dy = 0.1*(max(Tau(:,1)) - min(Tau(:,1)));
plot([min(N(:,1))-dx,max(N(:,1))+dx],[0,0],'-k','Linewidth',1.5)
plot([0,0],[min(Tau(:,1))-dy,max(Tau(:,1))+dy],'-k','Linewidth',1.5)
xlim([min(N(:,1))-dx,max(N(:,1))+dx])
ylim([min(Tau(:,1))-dy,max(Tau(:,1))+dy])
set(gca,'fontsize',fz,'DataAspectRatio',[1 1 1])
grid on
box on


end