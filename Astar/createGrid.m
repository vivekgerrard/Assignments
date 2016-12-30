 function [nodeCoords] = createGrid(X,Y)
%% Understand the use of the meshgrid command. It will be very useful for other applications you will come across in the future
%% Type "help meshgrid" on the MATLAB command line to learn more.
[Xg,Yg] = meshgrid(X,Y);

Xv = Xg(:);
Yv = Yg(:);

nodeCoords = [Xv';Yv'];