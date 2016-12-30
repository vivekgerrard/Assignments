clear all;close all;clc
format long;
par.gamma = 0;
par.g = 9.81;
par.m1 = 2;
par.m2 = 2;
par.m3 = 5;
par.m4 = 2;
par.a1 = 1;
par.a2 = 1;
par.a3 = 1;
par.a4 = 0.85;
par.c1 = 0.2;
par.c2 = 0.2;
par.c3 = 0.2;
par.c4 = 0.2;
par.I1 = (1/15)*par.m1*par.a1^2;
par.I2 = (1/15)*par.m2*par.a2^2;
par.I3 = (1/15)*par.m3*par.a3^2;
par.I4 = (1/15)*par.m4*par.a4^2;
%% Problem setup.

qinit = [0.3, -0.3, -0.2, -0.2];
qgoal = [0.3, -0.3, -1.3, 0.2];

enable_obstacle = true;

phi3_range = [-0.2, -1.3];
phi4_range = [-0.2, 0.4];
%% RRT Implementation
initNode = [-0.2, -0.2];
goalNode = [-1.3, 0.2];

MAX_NODES = [1000];
num_path_steps = [10];

path_js = rrt(par, initNode, goalNode, MAX_NODES, num_path_steps, phi3_range, phi4_range);
%% Create trajectory from path and visualize
close all;
dt = 0.1;
t = (size(path_js,2) - 1) - dt;
tVec = 0:dt:t;
qtraj = ones(numel(tVec),1)*qinit;
qtraj(:,3) = interp1(linspace(0,t,(size(path_js,2))),path_js(1,:), tVec);
qtraj(:,4) = interp1(linspace(0,t,(size(path_js,2))),path_js(2,:), tVec);
%angle_traj = ;
% Get the path of the end effector
eef_path = getEndEffectorPositions(par,path_js);
body_animate(tVec,qtraj,par, eef_path',enable_obstacle);