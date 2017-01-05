function [ image_out ] = closing( image_in, closing_size )
%CLOSING Perform a morphological opening
im_dilated = dilation(image_in, closing_size);
image_out = erosion(im_dilated, closing_size);
%%TODO: Implement the morphological closing
end