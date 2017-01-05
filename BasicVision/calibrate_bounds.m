function [ par ] = calibrate_bounds(image_in, par)
%CALIBRATE_BOUNDS Calibrate the bounds for segmentation
%getrect(image_in)
 figure(10);
 % subplot(1,3,channel);
imshow(image_in(:,:,1));
rect = round(getrect);

H_calib = image_in(round(rect(2)): round(rect(2)+rect(4)),round(rect(1)):round(rect(1)+rect(3)), 1);
S_calib = image_in(round(rect(2)): round(rect(2)+rect(4)),round(rect(1)):round(rect(1)+rect(3)), 2);
% TODO: Determine the lower and upper bounds for the H and S channels.
par.bound_H = [min(min(H_calib)) max(max(H_calib))];
par.bound_S = [min(min(S_calib)) max(max(S_calib))];
end

