function [] = stereonetplot(strike, dip, rake, c, cl)
if nargin == 3
    c = 'k';
    cl = 'r';
    CV = [];
end

if nargin == 4
    cl = 'r';
    CV = [];
end

if nargin == 5
    if length(c) > 1
        nCV = 50;
        cv = cl - min(cl);
        cv = cv / max(cv);
        icv = round(cv * nCV);
        icv = icv +1;
        [~,pos] = max(icv);
        icv(pos) = nCV;
        CV = jet(nCV);
    else
        icv = 1:length(strike);
        for ii=1:length(strike)
            CV(ii,1) = cl;
        end
    end
else
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

if nargin == 5
    for ii =1:length(strike)
        stereoplot1(dipdir(ii), dip(ii), rake(ii), c, CV(icv(ii),:))
    end
else
    for ii =1:length(strike)
        stereoplot1(dipdir(ii), dip(ii), rake(ii), c, cl)
    end
end

if nargin == 5
    if length(cl) > 1
        colormap('jet')
        colorbar;
        caxis([min(cl) max(cl)])
    end
end
end