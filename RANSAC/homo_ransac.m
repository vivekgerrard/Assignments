function homo_norm = homo_ransac(p)

%Obtain the matched points
[pl,pr] = assign5_2;
siz = size(pl);
H =[];
inliers = 0;
inlier_points = [];
best_plane = 0;
best_indices = [];
for k = 1:3000
    %As 4 points are required for homography
    for i = 1:4
        a = ceil(rand()*siz(2));
        xl=pl(1,a); yl=pl(2,a);
        xr=pr(1,a); yr=pr(2,a);
        %B matrix
        h = [-xl,-yl,-1,0,0,0,xr*xl,xr*yl,xr;
            0,0,0,-xl,-yl,-1,yr*xl,yr*yl,yr];
        H = [H; h];
    end
    
    %As B is in the null space of h
    n = null(H);
    %Determining the homography matrix
    H = (reshape(n(:,1),[3,3]))';
     for j = 1: siz(2)
            pr_est = H*[pl(:,j);1];
            pr_est = pr_est/pr_est(3);
            
            %Least square
            dist = sqrt(sum((pr(:,j)-pr_est(1:2)).^2)) ;
            
            %threshold of 5 pixel for frame A and frame B
             if abs(dist)<=5
                inliers = inliers+1;
                inlier_points = [inlier_points; j];
            end
     end
     if inliers>best_plane
         best_plane = inliers;
         best_indices = inlier_points;
     end
     inliers = 0;
     inlier_points =[];
     H = [];
end

%Calculating the homography matrix based on the inlier set
 bsiz = size(best_indices);
 for i =1: bsiz
     xl=pl(1,best_indices(i)); yl=pl(2,best_indices(i));
     xr=pr(1,best_indices(i)); yr=pr(2,best_indices(i));
     h = [xl,yl,1,0,0,0,-xr*xl,-xr*yl,-xr;
         0,0,0,xl,yl,1,-yr*xl,-yr*yl,-yr];
     H = [H; h];
     inlier_points = [inlier_points,[xl;yl]];
 end
 
  %SVD for best estimate
 [U,~,~] = svd(H');
 best_homo = U(:,9);
 homo = (reshape(best_homo,[3,3]))';
 homo_norm = homo/homo(3,3);
 
 %Plotting the inliers and given points
 plotpoints(homo, [p,inlier_points]);
end

function plotpoints(h, p)
siz = size(p);
P=[];
il = imread('frameB1.jpg');
ir = imread('frameB2.jpg');

%Showing the point set in left image
figure(1)
imshow(il)
hold on
scatter(p(1,1:4),p(2,1:4),'filled','r')
scatter(p(1,4:siz(2)),p(2,4:siz(2)),'filled','b')
hold off
for i = 1:siz(2)
    pr = h*[p(:,i);1];
    P = [P,[pr(1)/pr(3);pr(2)/pr(3)]];
end

%Estimated points(red) with the inliers(blue) in the right image
figure(2)
imshow(ir)
hold on
scatter(P(1,1:4),P(2,1:4),'filled','r')
scatter(P(1,4:siz(2)),P(2,4:siz(2)),'filled','b')

% Just the Estimated points in the right image
figure(4)
imshow(ir)
hold on
scatter(P(1,1:4),P(2,1:4),'filled','r')
%scatter(P(1,4:siz(2)),P(2,4:siz(2)),'filled','b')
end
