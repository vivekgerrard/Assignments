function epi = epipolar(R, T, Al, Ar)
Il = imread('left17.ppm');
Ir = imread('right17.ppm');
[E, F] = essential_fundamental(R, T, Al, Ar);
figure;
imshow('left17.ppm')
[X,Y] = ginput(1)
hold on;
epi_line = F*[X;Y;1];
figure;
imshow('right17.ppm')
points = lineToBorderPoints(epi_line',size(Ir));
line(points(:,[1,3])',points(:,[2,4])');
end