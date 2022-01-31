function [J1, J2, MJm3] = calcEnergyS(sigma123, YM,PM)
T1 = sigma123(:,1)+sigma123(:,2)+sigma123(:,3);
J1 = T1.^2/(2*YM);
% J1 = 0.5*(sum(sigma123.^2,2))/YM;
J2 = 0.5*((-2.0*(1+PM)*(sigma123(:,2).*sigma123(:,3)+sigma123(:,3).*sigma123(:,1)+sigma123(:,1).*sigma123(:,2))) / YM);
% MJm3 = 0.5*(sum(sigma123.^2,2)-2*(1+PM)*(sigma123(:,2).*sigma123(:,3)+sigma123(:,3).*sigma123(:,1)+sigma123(:,1).*sigma123(:,2)))/YM;
% MJm3 = 0.5*(sum(sigma123.^2,3)-2*(1+PM)*(sigma123(:,2).*sigma123(:,3)+sigma123(:,3).*sigma123(:,1)+sigma123(:,1).*sigma123(:,2)))/YM;
MJm3 = J1 + J2;
end