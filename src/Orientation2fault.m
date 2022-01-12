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