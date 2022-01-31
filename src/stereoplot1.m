function stereoplot1(dipdirA1,dipA1,rake1,c,cl,ls,pp)

% This function plots the orienations of a fold defined by fold axial
% plane orientation (dip direction and dip) and rake of fold axis in a
% stereonet with radius 1.


if nargin == 3
    c = 'k';
    cl = 'r';
    ls = '-';
end

if nargin == 4
    cl = 'r';
    ls = '-';
end
if nargin == 5
    ls = '-';
end

    
%==========================================================================
% Ensure no division by zero occurs
if dipA1  == 0
    dipA1 = 1e-6;
end
% if dipA2  == 0
%     dipA2 = 1e-6;
% end

% Degree to radians and vice versa factors and square root of 2.0
deg = 180/pi;   rad = pi/180;   s2 = sqrt(2);

% Vectors for plotting great circles
N = linspace(0,pi,181);

%==========================================================================

% First Fold Axial Plane
great_c = N - dipdirA1*rad;
apparent_dip = atan(tan(dipA1*rad).*sin(N));
r = s2.*sin(pi/4.0 - apparent_dip/2.0);
[gx,gy] = pol2cart(great_c,r);
plot(gx,gy,ls,'color',cl,'LineWidth',2);
i = floor(length(N)/2.0);
% text(gx(i)+0.05,gy(i),[' FAP_1 = ',num2str(round(dipdirA1)),' / ', num2str(round(dipA1))],'BackgroundColor',[1 1 1]);

% First Fold Axis
plunge1 =  abs(asin(cos(rake1*rad-pi/2)*sin(dipA1*rad))*deg);
pdd_diff = acos(tan(plunge1*rad)/tan(dipA1*rad))*deg;
if ~isreal(pdd_diff)
    disp('imaginary!!')
end
sgn = sign(rake1);
if sgn == 0
    sgn = 1;
end
plungedir1 = dipdirA1 - sgn*pdd_diff;

if plungedir1 < 0.0
    plungedir1 = 360.0 + plungedir1;
end

r = s2.*sin(pi/4.0 - plunge1*rad/2.0);
[X1,Y1] = pol2cart(-plungedir1*rad+pi/2,r);
hold on
scatter(X1,Y1,'ko','MarkerFaceColor',c,'ZData',200)
[d1,d2,d3,d4] = SDR2DDRPT2(dipdirA1-90,dipA1,rake1);
if nargin == 7
    % Y2 = Y1 + 0.25*sind(d4);
    % X2 = X1 + 0.25*cosd(d4);
    % plot([X1,X2],[Y1,Y2],'color',pp,'linewidth',2)
    quiver(X1,Y1,0.25*cosd(d4),0.25*sind(d4),'color',pp,'linewidth',2)
end
% plot(X1,Y1,'ro','MarkerFaceColor',c,'ZData',200);
% text(X1+0.05,Y1,[' b_1 = ',num2str(round(plungedir1)),' / ', num2str(round(plunge1))],'BackgroundColor',[1 1 1]);
end

