function [goalId] = getGoalId(gridCoords,q_goal)
% Compute the grid index corresponding to the goal coordinates.
x = q_goal(3);
y = q_goal(4);
for i = 1:length(gridCoords)
    if gridCoords(:,i) == [x;y]
        goalId = i;
        continue
    end
end
