function [complete_path] = rrt(par, initNode, goalNode, MAX_NODES, num_path_steps, phi3_range, phi4_range)
% Initialize the root node.
tree_idx = 1;
treeNodes(tree_idx).parent = 0;
treeNodes(tree_idx).coord = [initNode(1); initNode(2)]; %TODO
goal_tolerance = 0.001;
%Initialize the path to the goal to be an empty array
path_js = [];

for num_nodes = 1: 1: MAX_NODES%Loop over the maximum number of nodes.
    % Randomly sample joint values in the valid range
    randNode = sampleRandomNode(phi3_range,phi4_range, goalNode); % TODO
    % Find the id of nearest neighbor in the tree to connect to.
    nnId = findNearestNeighbor(treeNodes,randNode); %TODO
    % Get the C-space coordinates of the nearest neighbor.
    neighbor = treeNodes(nnId).coord;
    %Compute the joint space path between nearest neighbor and the random node.
    pathToRandNode = computePath(neighbor, randNode, num_path_steps); % TODO
    
    % Choose the potential new node coordinates to be added to the tree.
    newNode = randNode; % TODO
    
    % Perform collision checking to ensure the potential candidate to be
    % added to the tree and the path to it are collision free. The same
    % collision checking criteria holds for this part of the assignment
    % too. The end effector must maintain a clearance of 0.1 m from the
    % obstacles.
    [eef_coords] = getEndEffectorPositions(par, pathToRandNode);
    %Get C-space obstacle
    obs_discretization_steps = 3;
    obs_range = [0.6, 0.9];
    obs_coords = discretizeObstacle(obs_range,obs_discretization_steps);
    
    [obsList] = findObstacles(eef_coords,obs_coords);
    % If the potential new node and the path to it are collision tree,
    % update the treeNode list with the new node.
    if(length(obsList)==0)
        % Save the nearest neighbour as the parent node.
        tree_idx = tree_idx+1;
        treeNodes(tree_idx).parent = nnId;
        treeNodes(tree_idx).coord = newNode;
        % Check if the new node added to the tree is within the goal
        % tolerance.
        nNode = getEndEffectorPositions(par, [newNode, goalNode']);
        %gNode = getEndEffectorPositions(par, goalNode);
        if (goalReached(nNode(:,1), nNode(:,2), goal_tolerance)>0)
            sprintf('Goal reached')
            % Construct the path to the goal by tracking the parents of the
            % different nodes along the found node path.
            % WRITE YOUR CODE HERE!!
            rParent = treeNodes(tree_idx).parent;
            treeIDPath = [tree_idx];
            while(rParent ~= 1)
                treeIDPath = [rParent treeIDPath];
                rParent = treeNodes(rParent).parent;
            end;
            treePath = [1 treeIDPath];
            for pIdx=1:length(treePath)
        path_js(:,pIdx) = treeNodes(treePath(pIdx)).coord;%Write your code here. Hint: Use the node structure that you created before.
            end
            break
        end
           % TODO: Terminate the loop and return the path
    end
end
t = [];
for pIdx=1:length(treeNodes)
t = [ t treeNodes(pIdx).coord];
end
h =figure
plot(t(1,:), t(2,:),'Marker', 'o')
pause(5)
complete_path = path_js; 
end
%g = getEndEffectorPositions(par, complete_path)
