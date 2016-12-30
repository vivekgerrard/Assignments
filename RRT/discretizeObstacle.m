function [obs_coords] = discretizeObstacle(obs_range, obs_discretization_steps)
% Discretize the obstacle based on a chosen number of discretization steps.
ref_x = 0.5;
ref_y = 0;
define_obs = [-0.1, 0.1, obs_range(1)-0.1];
obs_coords =  [define_obs+ref_x; ((obs_range(2))*ones(1,obs_discretization_steps))];