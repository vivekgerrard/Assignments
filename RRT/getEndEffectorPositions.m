function [xy_eef] = getEndEffectorPositions(par, gridCoords)
% Use forward kinematics to compute the position of the end-effector for a
% given pair of grid coordinates.
xy_eef = [];
for i=1:length(gridCoords)
    %pos = rotation_matrix(0.3)*[par.a2;0] + rotation_matrix(-gridCoords(1,i))*[par.a3;0] + rotation_matrix(gridCoords(2,i))*[-par.a4;0]
    pos = coor(0.3, par.a1)+coor(gridCoords(1,i), par.a3)-coor(gridCoords(2,i), par.a4);
    %pos = eval(pos);
    xy_eef(:,i) = pos;
end


function d = coor(p, a) %calculates local coordinates using angles
d = [-a*sin(p),a*cos(p)];