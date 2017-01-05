function [ image_out ] = dilation( image_in, dilation_size )
%DILATION Apply a morphological DILATION to the input image
%       Use a square structuring element of size NxN, where N=dilation_size.

dims = size(image_in);
%image_out = image_in;
centre = (1 + dilation_size)/2;
temp_out = 255*ones(dims);
if(rem(dilation_size, 2) ~= 1 || dilation_size < 3)
   sprintf('Structuring element size is %d, which is not valid. It must be be odd and larger than 2.', erosion_size)
   return
end
struct_element = zeros(dilation_size, dilation_size);
for i = 1:1:(dims(1)-(dilation_size-1))
    for j = 1:1:(dims(2)-(dilation_size-1))
        im =image_in(i:(i+(dilation_size-1)), j:(j+(dilation_size-1))); %since it is a square structuring element, we can directly equate it to 1
        b = find(struct_element==0);
        if(im(b) == 0)
            temp_out((i+(centre-1)),(j+(centre-1)))=0;
        end
    end
end
image_out = temp_out; 

% TODO: Implement the dilation
% Hint: use a sliding window approach
%image_out = [];

end

