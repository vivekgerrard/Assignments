function [nodes] = createAstarNodes(gridSize,coords)
%% Remember: The number of nodes is different from the grid size!
s = struct([]);
for idx=1:1:(gridSize^2)%number of nodes
    s(idx).id = idx;
    s(idx).coord = [coords(:,idx)];
    s(idx).nextDoorNeighbors = [];
    s(idx).parent = 0;
%% Write your code here. You have to create a node "Structure" as described in the assignment.
%% See the "par" structure in the script file for example. More importantly, remember, this is an array of structures.
%% EACH NODE IS ONE STRUCTURE!

end;
nodes = s;
end