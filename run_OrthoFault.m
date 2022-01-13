clc
clear
close all


[filepath,~,~] = fileparts(which('run_OrthoFault.m'));
addpath([filepath,'/src'],'-end')
cd(filepath)
cd('data')

%% Parameters and data
% The data sources are numbered by the reference nuber in Wetzler and Reches (2022)
% filename = 'KTB-amphibolite.txt'; YM = 95000;PM = 0.26; % (1) Source: 11 
% filename = 'Yuubari-shale.txt'; YM = 15000;PM = 0.2;   % (2) Source: 11
% filename = 'Dunham-dolomite.txt'; YM = 111000;PM = 0.22; % (3) Source: 11
% filename = 'Mount-Scott granite.txt'; YM = 78000; PM = 0.22; % (4) Source: 24
filename = 'Shirahama-sandstone.txt';YM = 11500;PM = 0.38; % (5) Source: 11
% filename = 'Solenhofen-limestone.txt'; YM = 72500;PM = 0.34; % (6) Source: 11
% filename = 'Westerly-granite-3D.txt'; YM = 70000;PM = 0.2; % (7) Source: 23 
% filename = 'Westerly-granite-triaxial.txt'; YM = 70000;PM = 0.2; % (8) Source: 21
% filename = 'Westerly-granite-extension.txt'; YM = 70000;PM = 0.2; % (9) Source: 21
% filename = 'Maha-Sarakham-salt.txt'; YM = 22200;PM = 0.37; % (10) Source: 26
% filename = 'Berea-sandstone.txt'; YM = 11000;PM = 0.2; % (11) Source: 22
% filename = 'Tautona-quartzite.txt'; YM = 76800; PM = 0.21; % (12) Source: 27
% filename = 'Carrara-marble.txt'; YM = 40000;PM = 0.28; % (13) Source: 25 
% filename = 'Stripa granite.txt'; YM = 84000;PM = 0.22; % (14) Soure: 28


%% Selected a plane 
ip = 4;

%% Load the stress file
DAT = importfiledata(filename);

%% Run inversion
DAT = OrthoFault(DAT,PM,YM);

%% Plot result
PlotResults3DStrainA(DAT,ip)

