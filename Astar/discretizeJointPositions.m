function [v1, v2] = discretizeJointPositions(phi3Range,phi4Range,numSteps)
%% Discretize the Joint Positions into the specified number of steps
%% HINT: Use the MATLAB command "linspace". Type "help linspace" on MATLAB command line for more information
v1 = linspace(phi3Range(1), phi3Range(2), numSteps);
v2 = linspace(phi4Range(1), phi4Range(2), numSteps);
