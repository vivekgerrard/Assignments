function [ x y radius ] = find_ball( edge_image, par )
%FIND_BALL Apply Hough Transform to find the ball

% TODO: use houghcircle to find the ball in your edge image
hough_transform = houghcircle(edge_image, par.ball_radii(1), par.ball_radii(2));
% Hint: use 'find' and 'ind2sub' to find the strongest result in the hough
% transform.
[~,d] = max(hough_transform(:)) %d gives the indices of the maximum value.
[x y radius] = ind2sub(size(hough_transform),d);
radius = radius + par.ball_radii(1)
end