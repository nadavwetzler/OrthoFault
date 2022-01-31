function supertitle1(mytitle,varargin)

FSZ = 16;


mytitle = {mytitle ; '  '; '  '};
axes('Units','Normal');
if (~isempty(varargin))
    h = title(mytitle,varargin{1:length(varargin)});
else
    h = title(mytitle,'fontsize',FSZ,'FontWeight','bold');
end
set(gca,'visible','off')
set(h,'visible','on')
