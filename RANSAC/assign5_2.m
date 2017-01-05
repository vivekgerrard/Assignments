%% Assignment 5
function [pl,pr] = assign5_2()
clear all
close all
clc

il = imread('frameB1.jpg');
ir = imread('frameB2.jpg');
gl = rgb2gray(il);
gr = rgb2gray(ir);
gl = single(gl);
gr = single(gr);

lev = 6; tp = 0; ep = 10; th = 1.5;
figure(1)
hold on
[fl,dl] = vl_sift(gl,'Levels',lev,'PeakThresh',tp,'EdgeThresh',ep,...
    'Magnif',3,'WindowSize',2,'Verbose');
imshow(uint8(gl)) 
vl_plotframe(fl)
figure(2)
hold on
[fr,dr] = vl_sift(gr,'Levels',lev,'PeakThresh',tp,'EdgeThresh',ep,...
    'Magnif',3,'WindowSize',2,'Verbose');
imshow(uint8(gr))
vl_plotframe(fr)

[m,s] = vl_ubcmatch(dl,dr,th);
figure(1)
hold on
%plot(fl(1,m(1,:),fl(2,m(1,:))),'o')
xl = fl(1,m(1,:)); yl = fl(2,m(1,:));
pl =[xl;yl];
plot(xl,yl,'ro')
hold off
figure(2)
hold on
%plot(fr(1,m(2,:),fr(2,m(2,:))),'o')
xr = fr(1,m(2,:)); yr = fr(2,m(2,:));
pr = [xr;yr];
plot(xr,yr,'ro')
hold off

figure(3)
plotmatches(gl,gr,fl,fr,m)

