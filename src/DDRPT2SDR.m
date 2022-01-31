function [ Strike,Dip1,RakeR] = DDRPT2SDR( Dip1, DipDir , Plunge, Trend )
% The function converts convensional focal mechanism solution
% in the format of : Dip, Dip directio, Plunge, and Trend to
% Strike Dip Rake
if nargin == 1
    data = Dip1;
    Dip1 = data(:,1);
    DipDir = data(:,2);
    Plunge = data(:,3);
    Trend = data(:,4);
end


l(1) = length(Dip1);
l(2) = length(DipDir);
l(3) = length(Plunge);
l(4) = length(Trend);
checklengths = unique(l);
if (length(checklengths) > 1)
    error('Check vector lengths')
    
else
    
    Strike =make360(DipDir - 90);
    RakeR = make180(asind(sind(Plunge)./sind(Dip1))-180);
    
    I1 = make360(DipDir - Trend)>0 & make360(DipDir - Trend)<=180;
    I2 = make360(Trend - DipDir) >= 270;
    I = or(I1 , I2);
    RakeR(I) = -(RakeR(I)+ 180);
    RakeR = round(make360(RakeR))';
    Strike = round(Strike);
    Dip1 = round(Dip1);
    if nargout == 1
        Strike = Strike';
        Strike(:,2) = Dip1;
        Strike(:,3) = RakeR;
    end
end
end

