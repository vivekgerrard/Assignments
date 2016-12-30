function [nnId] = findNearestNeighbor(treeNodes, randNode)
% Find the node that is closest to the random node. Use the euclidean
% distance as a metric.
distance = Inf;
for i = 1:length(treeNodes)
    t = treeNodes(i).coord;
    temp_distance = sqrt(sum((randNode-t).^2));
    if temp_distance< distance
        nnId = i;
        distance = temp_distance;
    end
end
%nnId = [];