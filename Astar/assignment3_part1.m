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

phi3_range = [];
phi4_range = [];

%enable_obstacle = false;
enable_obstacle = true;
%Define initial and goal configurations
qinit = [0.3, -0.3, -0.2, -0.2];
qgoal = [0.3, -0.3, -1.3, 0.4];

%% Check initial configuration.

%Create test trajectory for animation
t = 0.1;
dt = 0.02;
tVec = 0:dt:t;
qtraj = ones(numel(tVec),1)*qinit;

body_animate(tVec,qtraj,par,[], enable_obstacle);
%% Discretize the joint positions for A* search
%% TODO
numGridSteps = 3;
[phi3,phi4] = discretizeJointPositions ([-0.2, -1.3],[-0.2, 0.4],numGridSteps);
gridCoords = createGrid(phi3,phi4);
distanceMatrix = getDistances(gridCoords);
grid_test = checkGrid(distanceMatrix);
if(grid_test)
    sprintf('Discretization and Distance Matrix check OK!')
else
    sprintf('Sorry.Check your discretization and distance matrix computation\n')
    sprintf('Steps to Debug:\n1: Check if you have correctly entered the joint position ranges into the discretizeJointPositions function\n2: Check if you are correctly passing the resulting grid coordinates to the dist function\n')
end;
%% ***************************Astar search (without obstacle)**************
%Step 1: Create the list of nodes for the A* search
nodesList = createAstarNodes(numGridSteps,gridCoords);
%Step 2: Create the Open and Closed Lists
idxStart = getGoalId(gridCoords, qinit); %idxStart needs to be changed according to the initial point
idxGoal = getGoalId(gridCoords, qgoal);
[path_js] = Astar(nodesList,idxStart,idxGoal,distanceMatrix,numGridSteps,[]);
%% Visualize the path
close all;
dt = 0.1;
t = (size(path_js,2) - 1) - dt;
tVec = 0:dt:t;
qtraj = ones(numel(tVec),1)*qinit;
qtraj(:,3) = interp1(linspace(0,t,(size(path_js,2))),path_js(1,:), tVec);
qtraj(:,4) = interp1(linspace(0,t,(size(path_js,2))),path_js(2,:), tVec);
angle_traj = getEndEffectorPositions(par,path_js); %HINT: You can use the "interp1" function of MATLAB.
%body_animate(tVec,qtraj,par,angle_traj',enable_obstacle);
body_animate(tVec,qtraj,par,[],enable_obstacle);
%% ***************************Astar search (with obstacle)*****************
% Visualize the obstacle
t = 0.1;
dt = 0.02;
tVec = 0:dt:t;
qtraj = ones(numel(tVec),1)*qinit;
body_animate(tVec,qtraj,par,[], enable_obstacle);
%% Modify the grid size and get new grid coordinates.
% Change the grid size to 16 x 16
numGridSteps = 16;
% Get the new grid coordinates
[phi3,phi4] = discretizeJointPositions ([-0.2, -1.3],[-0.2, 0.4],numGridSteps);
gridCoords = createGrid(phi3,phi4);
distanceMatrix = getDistances(gridCoords);
nodesList = createAstarNodes(numGridSteps,gridCoords);
%% Get C-space obstacle
[eef_coords] = getEndEffectorPositions(par, gridCoords);
% Discretize the obstacle
obs_discretization_steps = 3;
obs_range = [0.6, 0.9];
obs_coords = discretizeObstacle(obs_range,obs_discretization_steps);
% Find the grid indices corresponding to the obstacle
[obsList] = findObstacles(eef_coords,obs_coords);
%% Use A* algorithm modified to deal with obstacles to find path to goal.
idxStart = getGoalId(gridCoords, qinit);
idxGoal = getGoalId(gridCoords, qgoal);
[path_js] = Astar(nodesList,idxStart,idxGoal,distanceMatrix,numGridSteps,obsList);
%% Create trajectory from path and visualize
close all;
dt = 0.1;
t = (size(path_js,2) - 1) - dt;
tVec = 0:dt:t;
qtraj = ones(numel(tVec),1)*qinit;
qtraj(:,3) = interp1(linspace(0,t,(size(path_js,2))),path_js(1,:), tVec);
qtraj(:,4) = interp1(linspace(0,t,(size(path_js,2))),path_js(2,:), tVec);
%angle_traj = [];
% Get the path of the end effector
eef_path = getEndEffectorPositions(par,path_js);
body_animate(tVec,qtraj,par, eef_path',enable_obstacle);



