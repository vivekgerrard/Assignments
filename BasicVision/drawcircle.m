function [x,y] = drawcircle(pos,r)

for i = 1:100
    angle = i*(1/100)*2*pi;
    x(i) = pos(1)+ r*cos(angle);
    y(i) = pos(2)+ r*sin(angle);
end