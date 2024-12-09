%-----------------------
% 1-D NURBS PLOT
%-----------------------
clc; clear; close all;
addpath('geometry')
% Read the Geometry:
FileName = 'iga1D_example';
numPatch = 1; %Enter #Patches
% DOF per each control point:
local_dof = 1;
%-----------------------------------------------------
% Create 2-D Nurbs Structure (reads FileName)
%-----------------------------------------------------
Nurbs1D = iga1Dmesh(FileName,numPatch,local_dof);
%--------------------------------
% Plot Imported 2-D NURBS Structure
%-------------------------------
control_net = 1; % 1 to draw, otherwise 0
sampling = 1000;
nurbs1Dplot(Nurbs1D,control_net,sampling);
%