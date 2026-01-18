%---------------------------------------------------------------
% NURBS-Enhanced Mesh Generator for
% Spectral Element Method (SEM)
%---------------------------------------------------------------
clc; clear; close all;
addpath('geometry')
% Read the Geometry imported from Rhino:
FileName = 'iga2D_example_';
numPatch = 1; %Enter # Patches
% Degrees of Freedom per each node:
local_dof = 1;
%-----------------------------------------------------------------
% Create 2-D Nurbs Structure (reads FileName)
%-----------------------------------------------------------------
Nurbs2D = iga2Dmesh(FileName,numPatch,local_dof);
%-------------------------------
% Plot Physical Domain - Mesh
%-------------------------------
control_net = 1; % 1 to draw, otherwise 0
sampling = 100;
nurbs2Dplot(Nurbs2D,control_net,sampling);