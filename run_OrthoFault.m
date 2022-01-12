clc
clear
close all


[filepath,~,~] = fileparts(which('run_OrthoFault.m'));
addpath([filepath,'/src'],'-end')
cd(filepath)
cd('data')

%% Parameters and data
% filename = 'KTB-amphibolite-3D.txt'; YM = 95000;PM = 0.26; % (1)
% filename = 'Yuubari-shale2.txt'; YM = 15000;PM = 0.2;   % (2)
filename = 'Dunham-dolomite.txt'; YM = 111000;PM = 0.22; % (3)
% filename = 'Mount-Scott granite.txt'; YM = 78000; PM = 0.22; % (4)
% filename = 'Shirahama-sandstone.txt';YM = 11500;PM = 0.38; % (5)
% filename = 'Solenhofen-limestone.txt'; YM = 72500;PM = 0.34; % (6)
% filename = 'Westerly-granite-Haimson.txt'; YM = 70000;PM = 0.2; % (7)
% filename = 'Westerly-granite-Mogi-compression.txt'; YM = 70000;PM = 0.2; % (8)
% filename = 'Westerly-granite-Mogi-extension.txt'; YM = 70000;PM = 0.2; % (9)
% filename = 'Maha-Sarakham-salt.txt'; YM = 22200;PM = 0.37; % (10)
% filename = 'Berea-sandstone.txt'; YM = 11000;PM = 0.2; % (11)
% filename = 'Tautona-quartzite-triaxial-v2.txt'; YM = 76800; PM = 0.21; % (12)
% filename = 'Carrara-marble-v2.txt'; YM = 40000;PM = 0.28; % (13)
% filename = 'Stripa granite.txt'; YM = 84000;PM = 0.22; % (14)


%% Selected a plane 
ip = 4;

%% Load the stress file
DAT = importfiledata(filename);

%% Run inversion
DAT = OrthoFault(DAT,PM,YM);

%% Plot result
PlotResults3DStrainA(DAT,ip)














