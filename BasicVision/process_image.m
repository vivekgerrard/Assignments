function [ image_out ] = process_image( image_in,strel_size, par )
%PROCESS_IMAGE Use morphological operators to process the image

% TODO: Implement your own processing.
image_out = closing(image_in, strel_size);

end

