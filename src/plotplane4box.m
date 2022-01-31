function [] = plotplane4box(strikep,dipp,dx,dy)
sign1 = sign(dipp);
dipp = sign1*(90-abs(dipp));
[x, y] = meshgrid(-50:5:50);
planex = x*0;
planey = x;
planez = y;
s = surf(planex,planey,planez);
rotate(s,[0 1 0],dipp,[dx,dy,0])

rotate(s,[0 0 1],strikep,[dx,dy,0])
s.XData = s.XData + dx;
s.YData = s.YData + dy;

end