
function plotAll_Mohr(ax,sigma123,filename)
clrs = jet(size(sigma123,1));
for nn =1:size(sigma123,1)
    sig0 = sigma123(nn,:);
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
    plot(N(:,1),Tau(:,1),'color',clrs(nn,:),'linewidth',2.0)
    plot(N(:,2),Tau(:,2),'color',clrs(nn,:),'linewidth',1.0)
    plot(N(:,3),Tau(:,3),'color',clrs(nn,:),'linewidth',1.0)
%     plot(ax,N(:,1),Tau(:,1),'-r','linewidth',1.0);
%     plot(ax,N(:,2),Tau(:,2),':g','linewidth',1.0);
%     plot(ax,N(:,3),Tau(:,3),'b','linewidth',1.0);
    
end
xlabel(ax,'Normal Stress (MPa)','fontsize',fz);
ylabel(ax,'Shear Stress (MPa)','fontsize',fz);
title(ax,filename);
% set(ax,'fontsize',fz,'DataAspectRatio',[1 1 1])
axis(ax,'square');
grid(ax,'on');
box(ax,'on');
axis square

end