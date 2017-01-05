function D = dense_stereo(Il, Ir, W, R)
Il = rgb2gray(Il);
Ir = rgb2gray(Ir);
size_l = size(Il);
score =0;
disp_x = 0;
%disp_y = 0;
match = [];
for i = 1:size_l(1)
    for j = 1:size_l(2)
        disp = Inf;
        if Il(i,j)==255
            continue
        end
        if (i+W)<=size_l(1) && (j+W)<=size_l(2)
            %for k = -R:R Because the image is shifted only towards the right!
            for k = -R:(-R/2)
                %for l = -R:R There seems to be only translation along x axis, very small changes in y axis 
                %for l = round(-R/4):round(R/4)
                    if 0<(j+k) %(j+k+W)<=size_l(1) && 0<(i+k)
                               score = abs(double(Il(i:i+W,j:j+W))-double(Ir(i:i+W,j+k:j+k+W)));
                               score = sum(sum(score));
                        if disp > score
                          disp = score;
                          disp_x = k;
                          %disp_y = l;
                        end
                        score = 0;
                    else
                       continue
                    end
            end
            %end
           % disp_vector = [i; j; disp_x];% disp_y];
            match(i,j) = abs(disp_x);
        end
    end
end
D = match;
D2 = uint8(D);
imshow(D2);