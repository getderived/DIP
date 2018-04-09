%Erosión, starst to devore the object. Takes the elemento estructurante and
%checks if it's 

clear all; close all; clc
a = imread('figures.bmp');
[fil, col, cap]= size(a); if cap > 1; a = rgb2gray(a); end
ee = strel ('square', 3); b=a;
for i = 1: 100; b=imerode(b,ee); figure(1);imshow(b);pause(0.001);end