function [] = plotBoxOrthorombic(strikep, dipp, e)
hold on

dx = 20;
dy = 20;

% strain arrows
e = sort(e,'descend');
E = 10*abs(e / max(abs(e)));
dirE = sign(e);
dE = 12.5;
dEs = 2.5;
lw = 3;

plot3([0,0],[0,0],[-dE+dEs,-dE+dEs+E(1)],'r','linewidth',lw)
plot3([0,0],[0,0],[-dE-dEs,-dE-dEs-E(1)],'r','linewidth',lw)

plot3([0,0],[dEs,dEs+E(2)],[-dE,-dE],'g','linewidth',lw)
plot3([0,0],[-dEs,-dEs-E(2)],[-dE,-dE],'g','linewidth',lw)

plot3([dEs,dEs+E(3)],[0,0],[-dE,-dE],'b','linewidth',lw)
plot3([-dEs,-dEs-E(3)],[0,0],[-dE,-dE],'b','linewidth',lw)

plotplane4box(strikep,dipp,dx,dy) % R U
plotplane4box(strikep,-dipp,-dx,-dy) % L D
plotplane4box(-strikep,-dipp,-dx,dy) % L U
plotplane4box(-strikep,dipp,dx,-dy) % R D
xlabel('X')
ylabel('Y')
zlabel('Z')
limbox = 35;
axis equal
ax = gca;
ax.BoxStyle = 'full';
xlim([-limbox,limbox])
ylim([-limbox,limbox])
zlim([-limbox,0])
box on
grid on
caxis([-limbox,0])
view(45,45)
end