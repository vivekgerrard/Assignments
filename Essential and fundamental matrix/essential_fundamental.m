function [E,F]= essential_fundamental(R, T, Al, Ar)
S = [0, -T(3), T(2); T(3), 0, -T(1); -T(2), T(1), 0];
E = R*S;
F = inv(Ar')*E*inv(Al);
%[E_F] = [E; F];