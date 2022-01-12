function [SigN, MaxS] = calc_SIGN_MaxS(sigma123, N)
SigN = sigma123(:,1).*N(:,1).^2+sigma123(:,2).*N(:,2).^2+sigma123(:,3).*N(:,3).^2;
MaxS = sqrt((sigma123(:,1)-sigma123(:,2)).^2.*N(:,1).^2.*N(:,2).^2+(sigma123(:,2)-sigma123(:,3)).^2.*N(:,2).^2.*N(:,3).^2+(sigma123(:,3)-sigma123(:,1)).^2.*N(:,1).^2.*N(:,3).^2);
end
