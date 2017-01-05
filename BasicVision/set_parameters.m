function par = set_parameters
%%SET_PARAMETERS Set the parameters for this assignment.

%% Initialize vision variables

% the focal length of the optics 
par.f = 0.0045; % [m]
% the pixel size of the pixelmatrix of the imager
par.pixel_size = 6.2500e-06; % [m/px]

% The minimum and maximum ball radius in pixels to be searched
% by the Hough transform algorithm
par.ball_radii = [5 40];

% The true ball_radius in meters
par.ball_radius = 0.1;


