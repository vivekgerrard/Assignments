function [ edge_im ] = detect_edges( image_in, im_eroded )
%DETECT_EDGES Create an edge image using only morphological operators
edge_im = double(image_in) - double(im_eroded);
% TODO: Detect the inner edges of objects in the binary image.
%edge_im = []; 

end

