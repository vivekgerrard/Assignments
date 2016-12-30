function yourAstarBuddy(astarfig,gridSize,obstacleList,openList,closedList,gUpdateList,nodePath,start,goal)

%% Settings
numGridPoints = gridSize*gridSize;
%% Objects
clf
AxesHandle = axes('Parent',astarfig);
axis([0 gridSize+1 0 gridSize+1]);
for gridIdx = 1:1:numGridPoints
    if(ismember(gridIdx,obstacleList))
        colors(1,:) = [1 0 0];
    elseif(ismember(gridIdx,gUpdateList))
        colors(1,:) = [0 1 1];        
    elseif(ismember(gridIdx,closedList))
        colors(1,:) = [0 0 1];    
    elseif(ismember(gridIdx,openList))
        colors(1,:) = [0.5 0.5 0.5];
    else
        colors(1,:) = [1 1 1];
    end;
    gridPoint(gridIdx) = line('Parent',AxesHandle, 'MarkerFaceColor',colors(1,:),'Marker','o','MarkerSize',10);
end;
if(~isempty(nodePath))
    for gridIdx = 1:1:numel(nodePath)
        set(gridPoint(nodePath(gridIdx)),'MarkerFaceColor',[0 1 0],'Marker','o','MarkerSize',10);
    end;
end

%% Animation
% Plot the grid
[X Y] = meshgrid([1:gridSize]',[1:gridSize]');
X = X(:);
Y = Y(:);

for gridIdx = 1:1:numGridPoints,
    set(gridPoint(gridIdx),'Xdata',X(gridIdx),'Ydata',Y(gridIdx));
end;
xstart = get(gridPoint(start),'Xdata');
ystart = get(gridPoint(start),'Ydata');
text(xstart,ystart+0.25,'Start');
xgoal = get(gridPoint(goal),'Xdata');
ygoal = get(gridPoint(goal),'Ydata');
text(xgoal-0.15,ygoal+0.25,'GOAL!!','FontWeight','bold','FontSize',14);
drawnow
pause(1.0);
end


        
