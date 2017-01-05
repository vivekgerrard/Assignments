function S_R = Search_Range(E, Mr, Il, Ir, w)
[U, D, V] = svd(E); %Taking the svd of Essential matrix
W =[0,-1,0;1,0,0;0,0,1];
%Calculating the baseline
T = U*W*D*U';
Tx = T(3,2); 
%The focal length is taken as the first element from Mr(Right image
%intrinsic matrix)
f = Mr(1,1);
Z = [1,7]; %Depth
r1 = f*Tx*10^-3/Z(1); %Assuming the focal length is in pixels and baseline Tx is in mm.
r2 = f*Tx*10^-3/Z(2);
S_R= dense_stereo(Il, Ir, w, [round(r2),round(r1)]);
end
function D = dense_stereo(Il, Ir, W, R)
%Converting the images into grayscale
Il = rgb2gray(Il);
Ir = rgb2gray(Ir);
%The size of the image. Both the images have the same size.
size_l = size(Il);
score =0;
disp_x = 0; %Calculate the disparity along the x-axis
matchedpoint =[]; %Matched points
match = []; %Disparity matrix
for i = 1:size_l(1)
    for j = 1:size_l(2)
        disp = Inf;
        if Il(i,j)==255 %Constraint introduced to eliminate the noise or void in the image.
            continue
        end
        if (i+W)<=size_l(1) && (j+W)<=size_l(2) %A check to make sure the range is within the boundary of the image
            %for k = -R:R Because the image is shifted only towards the right!
            for k = -R(2):-R(1)
                %for l = -R:R There seems to be only translation along x axis, very small changes in y axis 
                    if 0<(j+k) %(j+k+W)<=size_l(1) && 0<(i+k)
                        score = abs(double(Il(i:i+W,j:j+W))-double(Ir(i:i+W,j+k:j+k+W)));
                        score = sum(sum(score));
                        if disp > score
                          disp = score;
                          disp_x = k;
                        end
                        score = 0;
                    else
                       continue
                    end
            end
%             disp_vector = [i;j;disp_x]; % Only needed for the method triangulate
%             matchedpoint = [matchedpoint disp_vector]; %Provides the matched points
            match(i,j) = abs(disp_x); %This is the disparity matrix
        end
    end
end
D = match;
imshow(mat2gray(match));
end