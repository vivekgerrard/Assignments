function [obsList] = findObstacles(eef_coords,obs_coords)
% Find the combinations of joint angles which would lead to the
% end-effector colliding with the obstacle or violate the 0.1m clearance
% constraint.
obsList = [];
for  i = 1:length(eef_coords)
    if(eef_coords(1,i)>obs_coords(1,1) & (eef_coords(1,i)<=obs_coords(1,2)) || (eef_coords(1,i)>obs_coords(1,3) & eef_coords(1,i)<=(obs_coords(1,3)+0.2)))
        if((eef_coords(2,i)<=obs_coords(2,1))||((eef_coords(1,i) - 0.5)^2 + (eef_coords(2,i) - 0.9)^2 < 0.01))
            obsList = [obsList, i];
        end
    end
end

            
            
       

