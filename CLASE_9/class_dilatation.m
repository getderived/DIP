% Hablamos de morfología (erosión y dilatación), para dilatación usamos un elemento estructurado que va a repertirnos la imagen de acuerdo a una matriz. 
% This example is for dilatation
clear all; close all; clc
a = imread('figures.bmp');
[fil, col, cap]= size(a); if cap > 1; a = rgb2gray(a); end
ee = strel ('square', 3); b=a;
for i = 1: 100; b=imdilate(b,ee); figure(1);imshow(b);pause(0.001);end