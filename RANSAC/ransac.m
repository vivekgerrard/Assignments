function best_normal = ransac(points)
siz = size(points);
p =[];
inliers = 0;
inlier_points = [];
best_plane = 0;
best_plane_points = [];
for k = 1:3000
    for i = 1:3
        
        % Stores the three randomly sampled points
        p = [p; points(ceil(rand()*siz(1)),:)]; 
    end
    
    %Find the cross product
    n = cross((p(2,:)-p(1,:)),(p(3,:)-p(1,:))); 
    
    %Unit vector in the normal direction
    n_unit = n/norm(n); 
    for j = 1: siz(1)
           dist = dot((points(j,:) - p(1,:)),n_unit);
           
           %Threshold
           %3mm for point dataset 1
           %3.3mm for point dataset 2
           %5mm for point dataset 3
           %0.003m for road point cloud
           if abs(dist)<=0.003
               inliers = inliers+1;
               inlier_points = [inlier_points; points(j,:)];
           end
    end
    
    %Determining the best inlier set
    if inliers>best_plane
        best_plane = inliers;
        best_plane_points = inlier_points;
    end
    inliers = 0;
    inlier_points =[];
    p =[];
end

%SVD
bsiz = size(best_plane_points);

%Mean of the inlier points
bmean =  (mean(best_plane_points)'*ones(1,bsiz(1)))'; 

%Inliers - mean 
best_plane_points = best_plane_points - bmean; 
[U,~,~] = svd(best_plane_points');

%Column corresponding to the least singular value
best_normal = U(:,3);

%Determining the plane (a,b,c,d)
plane = [best_normal', dot(best_normal',mean(best_plane_points))];

% Generate x and y data
% -20:2:20 for road and -3000:200:3000 for point dataset 1,2,3
[x y] = meshgrid(-20:2:20); 

% Solve for z data
z = -1/plane(3)*(plane(1)*x + plane(2)*y + plane(4)); 
figure(1)

%Plot the surface
surf(x,y,z); 
hold on;
scatter3(best_plane_points(:,1),best_plane_points(:,2),best_plane_points(:,3),'filled','r');
hold off;

%Calculation of the pitch
 Pitch_angle = acos(dot(best_normal,[0;0;1])); %in radian
 pitch_angle = 90 - (Pitch_angle*180/pi);
    
        
    
