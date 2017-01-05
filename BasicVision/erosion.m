function [ image_out ] = erosion( image_in, erosion_size )
%EROSION Apply a morphological EROSION to the input image
%Use a square structuring element of size NxN, where N=erosion_size.
dims = size(image_in);
%image_out = [image_in];
centre = (1 + erosion_size)/2;
temp_out = zeros(dims);
if(rem(erosion_size, 2) ~= 1 || erosion_size < 3)
   sprintf('Structuring element size is %d, which is not valid. It must be be odd and larger than 2.', erosion_size)
   return
end
struct_element = 255*ones(erosion_size, erosion_size);
for i = 1:1:(dims(1)-(erosion_size-1))
    for j = 1:1:(dims(2)-(erosion_size-1))
        im =image_in(i:(i+(erosion_size-1)), j:(j+(erosion_size-1))); %since it is a square structuring element, we can directly equate it to 1
        b = find(struct_element==255);
        if(im(b) == 255)
            temp_out((i+(centre-1)),(j+(centre-1)))=255;
        end
    end
end
image_out = temp_out;      
% TODO: Implement the erosion
% Hint: use a sliding window approach
%image_out = [];
end

