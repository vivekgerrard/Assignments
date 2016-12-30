function [path] = Astar(nList,start,goal,distanceMatrix,nGridSteps,obstacles)
% Create vectors for the f,g and h costs and initialize them
% The fcosts are initialized with a high value initially in order to avoid
% unexplored nodes from being selected for expansion. For example, if you
% initialize the fCosts for all nodes with zero, then after the first
% iteration, the node with zero cost will be selected. This node may not
% even be in the list of nearest neighbors!


fCost = Inf((nGridSteps^2),1);
gCost = Inf((nGridSteps^2), 1);
hCost = [];

% Create arrays called Open List and Closed Lists which will eventually be
% filled with nodes by the algorithm.

%The openList contains the start node ID to begin with.
openList = [start];

%The closed list is empty initially
closedList = [];

%The obstacle list contains the nodeIDs which belong to the C-space
%obstacle coordinates.
%% TODO: Only needed for the obstacle avoidance part of the assignment.
obsList = obstacles;% Write a function findObstacles.m to get the IDs of C-space obstacles
gUpdateList = []; % Nodes whose gCost are updated more than once.

% Begin the algorithm with the start node
curNode = nList(start);

%Initialize the gCost, hCost and fCost for the starting node
%Recall:
%gCost: Is the cost to reach a given node from the node you started from
%hCost: Is the heuristic cost to reach the goal
%fCost: Is the sum of gCost and hCost

gCost(start,1) = distanceMatrix(start, start);
hCost(start,1) = distanceMatrix(start, goal);
fCost(start,1) = gCost(start,1)+hCost(start,1);

astarfig = figure(10);

hold on;

%******* This is the main Astar loop*******
%It is necessary to keep running the loop until the goal ID
%is found in the closedList

%The "ismember" MATLAB function checks if an element is a 
%member of an array and returns a logical value of true or
%false. Type "help ismember" on the MATLAB command line to
%find out more

while(~ismember(goal,closedList))
    %% TODO
    curId = curNode.id;   %Extract the node ID of the current node from the nodeStructure
                  %HINT: Use the "dot" operator to access elements of a
                  %structure. Example: structName.memberName

    % Remove the current node ID from the open list and put it in the closed list
    % because you will be expanding it.
    % Here, the "setdiff" command is used. Type "help setdiff" on the MATLAB command
    % line to find out how it works.
    openList = setdiff(openList,curId);
    %fCost(curId) = Inf;
    %Add the node you are evaluating to the closed list
    %% TODO
    closedList = [closedList curId];
    yourAstarBuddy(astarfig,nGridSteps,obsList,openList,closedList,gUpdateList,[],start,goal);
    %Check if the current node is the goal node. If so, skip the rest of the
    %loop so that you will exit the loop in the next iteration. Use the
    %"continue" command to skip the rest of the loop.
    % WATCH OUT for the difference between nodeID and node usage. nodeID is
    % just a number and the node itself is a structure
    if(curId == goal)%Write your code here)
        continue %Write your code here
    end;
    %The current node is not the gool node. So, check the next door
    %neighbors to proceed towards the goal
    %curNode = nList(curId);
    curNode.nextDoorNeighbors = findNextDoorNeighbors(curId,nGridSteps);
    % For all the nearest neighbors that were found, you will now start
    % evaluating the gCost and the hCost unless they have already been
    % previously visited
    for nIdx = 1:1:numel(curNode.nextDoorNeighbors)
        %Get the first nearest neighbor from the list
        nDn = curNode.nextDoorNeighbors(nIdx);
        %Check if the nearest neighbor is already in the closed list or it
        %is in the list of obstacles.
        if(ismember(nDn,closedList)||ismember(nDn,obsList))
            %Neighbour already in closed list or an obstacle. No processing
            %required
            %Write your code here
            continue
        else
            %Neighbor not in the closed list or not an obstacle. Update the
            %costs
            %First compute the temporary gCost. It is temporary because, if
            %the new gCost is larger than the current gCost, there is no
            %need to update the gCost
            % TODO
        
            temp_gCost = gCost(curId)+distanceMatrix(nDn, curId);% Write your code here
            %If the neighbor is not a member of the open list, add the
            %neighbor to the open list
            %Note updateGCost can only take two values: true or false
            if(~ismember(nDn,openList))
                openList = [openList nDn];%Write your code here
                hCost(nDn) =distanceMatrix(nDn, goal); %Write your code here
                updateGCost = true; %Write your code here
            elseif temp_gCost < gCost(nDn)
                updateGCost = true;%Write your code here;
                gUpdateList = [gUpdateList, nDn];
            else
                updateGCost = false;
            end;
            if(updateGCost)
                %% TODO
                gCost(nDn) = temp_gCost;%Write your code here
                fCost(nDn) = gCost(nDn)+ hCost(nDn);%Write your code here
                %Update the parent of the current node to the new parent
                %which yielded a lesser cost path
                nList(nDn).parent = curId;%Write your code here
            end;
        end;
    end;
    %Choose the node in the open list with the least F_Cost for the next iteration
    [~,minId] =  min(fCost(openList)); %Write your code here. HINT: Use the "min" function of MATLAB
    
    %Choose the least F_cost node for next evaluation
    minFcostId = openList(minId); %Write your code here. You will find the ID of the least fCost node in the openList
    curNode = nList(minFcostId);%Write your code here. Update the current Node with the least fCost node for the next iteration
end;

%After the goal has been found, the path needs to be reconstructed by
%backtracking the parent nodeIDs until the startnode ID is found
nParent = nList(goal).parent;
nodeIDPath = [goal];
hCostPath = hCost(goal);
while(nParent ~= start)
    nodeIDPath = [nParent nodeIDPath];
    hCostPath = [hCost(nParent) hCostPath];
    nParent = nList(nParent).parent;
end;
% This array contains a list of nodeID path.
nodePath = [start nodeIDPath];
hCostPath = [hCost(start) hCostPath];

yourAstarBuddy(astarfig,nGridSteps,obsList,openList,closedList,gUpdateList,nodePath,start,goal);
hold off;
%hCost = figure;
%plot(nodePath, hCostPath, 'LineWidth',2, 'Marker', 'o')
%pause(10);
%Using the nodeID path, construct the C-space trajectory
for pIdx=1:1:length(nodePath)
    path(:,pIdx) = nList(nodePath(pIdx)).coord;%Write your code here. Hint: Use the node structure that you created before.
end;



    
    
    
        
    
    
