function [ segmented_im ] = segment( image_HSV, par )
%SEGMENT Segment the image based on the input parameters
H = image_HSV(:,:,1);
S = image_HSV(:,:,2);
dim = size(image_HSV(:,:,1));
H_bound = par.bound_H;
S_bound = par.bound_S;
segmented_im = zeros(size(image_HSV(:,:,1)), 'uint8');
for i = 1:1:dim(1)
    for j = 1:1:dim(2)
        if(H(i,j)> (H_bound(1)) & H(i,j)< (H_bound(2)) & S(i,j)> (S_bound(1)) & S(i,j)< (S_bound(2)))
            segmented_im(i,j) = 255;
        end
    end
% TODO: Implement your segmentation
%segmented_im = [];

end

