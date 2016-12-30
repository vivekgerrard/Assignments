function [nextDoorNeighbors] = findNextDoorNeighbors (nodeId,nGridSteps)

numNodes = 1:1:(nGridSteps^2);

% Create the node index matrix such that it looks as follows
% [ nGridSteps                   2*nGridSteps                   ... nGridSteps*nGridSteps
%   nGridSteps-1                 2*nGridSteps - 1               ... nGridSteps*nGridSteps - 1
%   ....                         ....                           ...
%   1                            2*nGridSteps - nGridSteps + 1  ... nGridSteps*nGridSteps - nGridStep + 1]
%Example for 3 x 3 grid
%[3 6 9
% 2 5 8
% 1 4 7]

%% HINT: Use the "reshape" and "flipud" commands in MATLAB for easy creation of the node index matrix
nodeVec = reshape( numNodes, [nGridSteps,nGridSteps]); %Write your code here
nodeMat = flipud(nodeVec); %Write your code here
%nodeMat = nodeVec; %Write your code here

%Initialize the nearest neighbors list
nextDoorNeighbors = [];

%Find the grid location of the current node in the nodeMatrix
%Hint: Use the "find" command in MATLAB
[nRow,nCol] = find(nodeMat == nodeId);

%Create a set of possible neighbors
%HINT: A set of numbers can be created in MATLAB in a very simple way. For
%example, if you want numbers from 1:5 with an increment of one, you can
%write it as: a = 1:1:5. The result will be a = [1 2 3 4 5]
nnRows = (nRow-1):1:(nRow+1); %Write your code here
nnCols = (nCol-1):1:(nCol+1); %Write your code here

%Discard the neighbors with illegal indices. Illegal indices are indices
%such as -1,0, etc. The minimum index in MATLAB is always "1" unlike other
%programming languages.

% Check for illegal row indices
i = find( nnRows>0 & nnRows<=nGridSteps);

nnRows = nnRows(i); %Write your code here
%nnRows %Write your code here

% Check for illegal column indices

j = find( nnCols>0 & nnCols<=nGridSteps);

nnCols = nnCols(j);%Write your code here
%nnCols = []; %Write your code here

% Create the nearest neighbor list
% IMPORTANT: Understand how the elements of the nodeMat matrix are indexed below
nextDoorNeighbors = [nodeMat(nnRows(1:end),nnCols(1:end))];
% Remove the current node from the list if it exists in the neighbor list
nextDoorNeighbors = setdiff(nextDoorNeighbors,nodeId);
end


