function [] = stereonetplot(strike, dip, rake, c)
if nargin == 3
    c = 'k';
end
hold on
axis equal, axis off, box off % equal scaling in x and y, no axes or box
axis ([-1 1 -1 1]) % sets scaling for x- and y-axes
 
plot([-1 1],[0 0],'k:',[0 0],[-1 1],'k:') % plot x- and y-axes
r = 1; % radius of reference circle
TH = linspace(0,2*pi,3601); % polar angle, range 2 pi, 1/10 degree increment
[X,Y] = pol2cart(TH,r); % Cartesian coordinates of reference circle
plot(X,Y,'k') % plot reference circle
 
for j = 1:8 % loop to plot great circles at 10 degree increments
phid = j*(10*pi/180); % dip angle, phid
h = -r*tan(phid); rp = r/cos(phid); % x-coord of center, h, and radius, rp
X = -h + rp*cos(TH); Y = rp*sin(TH); % coordinates of points on great circle
X(find(X.^2+Y.^2>r)) = nan; % eliminate points outside stereonet
plot(X,Y,'k:',-X,Y,'k:') % plot two sets of great circles
end
 
for j = 1:8 % loop to plot small circles at 10 degree increments
gam = j*(10*pi/180); % cone angle, gam
k = r/cos(gam); rp = r*tan(gam); % y-coord of center, k, and radius, rp
X = rp*cos(TH); Y = k + rp*sin(TH); % coordinates of points on small circle
Y(find(X.^2+Y.^2>r)) = nan; % eliminate points outside stereonet
plot(X,Y,'k:',X,-Y,'k:') % plot two sets of small circles
end
dipdir = make360(strike + 90);
for ii =1:length(strike)
    stereoplot1(dipdir(ii), dip(ii), rake(ii), c)
end