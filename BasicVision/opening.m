function [ image_out ] = opening( image_in, opening_size )
%OPENING Perform a morphological opening
im_eroded = erosion(image_in, opening_size);
image_out = dilation(im_eroded, opening_size);
% TODO: Implement the morphological opening
end