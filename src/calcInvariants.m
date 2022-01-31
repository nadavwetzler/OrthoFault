function [I1_2E, SQRT_J2, I2_2] = calcInvariants(sigma123,PM,YM)
I1 = sum(sigma123,2);
I1_2E = I1.^2/(2*YM);
SQRT_J2 = sqrt(((sigma123(:,1) - sigma123(:,3)).^2 + (sigma123(:,1) - sigma123(:,2)).^2 + (sigma123(:,2) - sigma123(:,3)).^2)/6);
I2_2 = -(2*(1+PM))*(sigma123(:,1).*sigma123(:,2) + sigma123(:,2).*sigma123(:,3) + sigma123(:,1).*sigma123(:,3))/(2*YM);
end