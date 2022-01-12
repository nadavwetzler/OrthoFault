function AddLetters2Plots(Fg_or_axes, Letters, NV)
% AddLetters2Plots - adds letters (A), (B), ... to subplots in a figure.
% This function adds letters to the axes located by default at the 
% top left of the axes on your figure. You can change the letters themselves, 
% define a list of axes on which you want to add letters, change the position 
% of the letters relative to the subplot (as well as positioning the letters 
% inside or outside the subplot), and change the font size. 
% 
% Syntax:  AddLetters2Plots(fg_or_axes,Letters,Name, Value)
% 
% Inputs:
%    fg_or_axes - figure or a cell array of axes, by defeult is the current
%    figure
%    Letters - cell array of letters, by default {'(A)',...'(Z)'})
%    AddLetters2Plots(fg_or_axes,Letters,Name1, Value1,Name2, Value2, ...) 
%    specifies one or more of the following name/value pairs:
%    'FontSize' 
%    'FontWeight' -- 'normal'  | 'bold'(default)
% 
%    'HShift' and 'VShift' - horizontal and vertical shifts
%    relative shift from 0 to 1 from the upper left cornner of the axis. default = 0 
%    positive values for plotting inside the subplots, negative for plotting
%    outside the subplots.  if HShift, VShift are vectors, then the different 
%    relative shifts are defined for each axis
% 
%    'Direction' = 'LeftRight' or 'TopDown'  label figures either from left
%    to right or from top to down
% 
% Example: 
%    AddLetters2Plots  adds  (A), (B) to current figure
%    AddLetters2Plots(fg)  adds  (A), (B) to figure fg
%    AddLetters2Plots(fg, {'(a)', '(b)', '(c)'})  adds  (a), (b) and (c)
%       to fg
%    AddLetters2Plots({ax1, ax2, ax3}, {'(a)', '(b)', '(c)'})  adds  (a),
%      (b) and (c) to axis1, axis2, axis3
%    AddLetters2Plots(fg, 'HShift', -0.08, 'VShift', -0.02, 'Direction', 'TopDown')
%       ads Default letters outside of figures, the order from top to
%       bottom
% Code example 
% add latters to all axes from top to bottom
% add latters to all axes from top to bottom
% fg = figure(1);
% clf
% subplot(2, 2, 1)
% subplot(2, 2, 2)
% subplot(2, 1, 2)
% legend
% colorbar
% AddLetters2Plots( 'HShift', [0, 0, 0], 'VShift', 0, 'Direction', 'LeftRight', 'FontSize', 10)
% %%
% % add latters to only some axes 
% fg = figure(2);
% clf
% ax1 = subplot(2, 2, 1);
% ax2 = subplot(2, 2, 2);
% ax3 = subplot(2, 1, 2);
% legend
% colorbar
% AddLetters2Plots({ax1, ax3}, {'A', 'B'})

% Author: Alexey Ryabov
% Work address
% email: alryabov@gmail.com
% Website:
% July 2021; Last revision: July 2021



%Alex Ryabov, 2021
%
% figure fg
arguments
    Fg_or_axes = gcf;
    Letters = strcat('(', cellstr(('A':'Z').'), ')');
    NV.FontSize = 12;
    NV.FontWeight  = 'bold';
    NV.HShift = 0.0;
    NV.VShift = 0.0;
    NV.Direction = 'LeftRight';
end
%if fg is a figure then get a list of axes
if isa(Fg_or_axes, 'matlab.ui.Figure')
    lAxes = {};
    Parent = Fg_or_axes;
    if isa(Fg_or_axes.Children, 'matlab.graphics.layout.TiledChartLayout')
        Children = Fg_or_axes.Children.Children;
    else
        Children = Fg_or_axes.Children;
    end
    for iCh = 1:length(Children)
        if isa(Children(iCh), 'matlab.graphics.axis.Axes')
            lAxes{end + 1} = Children(iCh);
        end
    end
    %sort lAxes by position
    Pos = NaN(length(lAxes), 2);
    for ia=1:length(lAxes)
        ax = lAxes{ia};
        Pos(ia, :) = [ax.InnerPosition(1),  ax.InnerPosition(2)];
    end
    Pos(:, 1) = -Pos(:, 1);
    switch NV.Direction
        case 'LeftRight'
            [~, ind] = sortrows(Pos, [2, 1], 'descend');
        case 'TopDown'
            [~, ind] = sortrows(Pos, [1, 2], 'descend');
    end
    Pos(:, 1) = -Pos(:, 1);
    lAxes = lAxes(ind);
else
    lAxes = Fg_or_axes;
    Parent = lAxes{1}.Parent;
end


if length(NV.HShift) == 1
    NV.HShift = repmat(NV.HShift, length(lAxes), 1);
end
if length(NV.VShift) == 1
    NV.VShift = repmat(NV.VShift, length(lAxes), 1);
end
%%add labels
for ia = 1:length(lAxes)
    ax = lAxes{ia};
    annotation(Parent, 'textbox',...
    [ax.InnerPosition(1) + NV.HShift(ia),  ax.InnerPosition(2) + ax.InnerPosition(4) - NV.VShift(ia) 0.0 0.0],...
    'String',Letters{ia},...
    'LineStyle','none',...
    'FitBoxToText','on',...
    'FontSize', NV.FontSize, ...  
    'FontWeight', NV.FontWeight);  
end
end

