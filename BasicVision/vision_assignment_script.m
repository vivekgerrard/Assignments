%% Initialize
clear;
close all;
clc;
par = set_parameters;

% Read image for the morphological operators assignment
binary_im = imread('morphological.png');
binary_im = binary_im(:,:,1); % Get rid of color channels, since this is a binary image

%% Binary Morphological operators
figure(1);
subplot(1,3,1);
imshow(binary_im); title('Binary image');

figure(2);
subplot(1,3,1);
imshow(binary_im); title('Binary image');

% TODO: Vary the structuring element size.
strel_size = 3;
figure(1)
im_eroded = erosion(binary_im, strel_size);
subplot(1,3,2);
imshow(im_eroded); title('Eroded image');


im_dilated = dilation(binary_im, strel_size);
subplot(1,3,3);
imshow(im_dilated); title('Dilated image');

figure(2);
im_opened = opening(binary_im, strel_size);
subplot(1,3,2);
imshow(im_opened); title('Opened image');

im_closed = closing(binary_im, strel_size);
subplot(1,3,3);
imshow(im_closed); title('Closed image');

figure(3);
subplot(1,2,1);
imshow(binary_im); title('Binary image');

im_edges = detect_edges(binary_im, im_eroded);
subplot(1,2,2);
imshow(im_edges); title('Edge image');

%% Recognizing an orange ball
% Load an image to work with
real_field = true;
if real_field
    image_RGB = imread('real_field.jpg');
else
    image_RGB = imread('virtual_field.jpg');
end

%% Show the image

figure(4);
imshow(image_RGB);
image_HSV = rgb2hsv(image_RGB);
%rect = getrect
%% Display the different color channels

% This section displays some image information. Use it as you see fit in
% your report.

%rgb_titles = {'Red channel', 'Green channel', 'Blue channel'};
 %hsv_titles = {'Hue', 'Saturation', 'Value'};
 %for channel = 1:1:3
  %  figure(5);
   %  subplot(1,3,channel);
    % imshow(image_RGB(:,:,channel));
     %title(rgb_titles(channel));

     %figure(6);
     %subplot(1,3,channel);
    % histogram(image_RGB(:,:,channel));
   %  title(rgb_titles(channel));
%     
   %  figure(7);
 %   subplot(1,3,channel);
  %  imshow(image_HSV(:,:,channel));


  %  title(hsv_titles(channel));
%     
     %figure(8);
     %subplot(1,3,channel);
    %histogram(image_HSV(:,:,channel))
    %title(hsv_titles(channel));
 %end;

%% Calibrate the bounds for the ball
struct_size = 3;
par = calibrate_bounds(image_HSV, par);

%% Segment and process the image

% TODO: Segment and process the image
segmented_image = segment(image_HSV, par);
processed_image = process_image(segmented_image,struct_size, par);
%processed_image_1 = process_image(segmented_image,7, par)

figure(9);
subplot(1,3,1);
imshow(image_RGB); title('Color image');
subplot(1,3,2);
imshow(segmented_image); title('Segmented Image');
subplot(1,3,3);
imshow(processed_image); title('Processed Image');

%% Detect the edges

% TODO: detect edges in the processed image
image_dilate = dilation(processed_image, struct_size);
edge_image = detect_edges(image_dilate, processed_image);
figure(10);
subplot(1,3,1);
imshow(image_RGB); title('Color image');
subplot(1,3,2);
imshow(processed_image); title('Processed image');
subplot(1,3,3);
imshow(edge_image); title('Edge image');

%% Perform Hough transform
% TODO: find the ball in the edge image
[x y radius] = find_ball(edge_image, par);
output_RGB = insertShape(image_RGB, 'circle', [x y radius], 'LineWidth', 3, 'Color', 'red');
figure(12);
imshow(output_RGB);

%% Triangulate the distance between camera and ball
distance = find_distance(radius, par)
