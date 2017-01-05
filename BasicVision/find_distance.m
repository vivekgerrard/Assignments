function [ distance ] = find_distance( radius, par )
%FIND_DISTANCE Triangulate the distance between camera and ball
% TODO: Calculate the camera-to-ball distance given the camera parameters
% and the observed ball radius
distance = par.f*(par.ball_radius/(radius*6.2500e-06));

end

