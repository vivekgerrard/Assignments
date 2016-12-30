function [reachedGoal] = goalReached(rNode,gNode,goal_tolerance)
if (norm(rNode - gNode) < goal_tolerance)
    reachedGoal = 1
else
    reachedGoal = 0;
end
% Check if the goal was reached within the joint space tolerance of 0.001.
% That is, if a certain tree node is within a circle of radius 0.001
