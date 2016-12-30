function [randNode] = sampleRandomNode(phi3_range, phi4_range, goalNode)
% Uniformly randomly sample a node of the tree in the specified joint angle
% ranges. A node is a vector of size n x 1 which contains valid values of
% corresponding joint angles in the specified range.
% Hint: Use the "rand" function.
if rand() <= 1
   randNode = [goalNode(1);goalNode(2)];
else
phi3_rand = phi3_range(1) + (phi3_range(2)-phi3_range(1))*rand();
phi4_rand = phi4_range(1) + (phi4_range(2)-phi4_range(1))*rand();
randNode = [phi3_rand; phi4_rand];
end