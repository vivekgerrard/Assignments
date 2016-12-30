function [path] = computePath(neighbor, randNode, num_path_steps)
% Compute a linear joint space path between the nearest neighbour and the
% random node with the specified number of steps.
phi3_path= linspace(neighbor(1), randNode(1), num_path_steps);
phi4_path= linspace(neighbor(2), randNode(2), num_path_steps);
path = [phi3_path; phi4_path];