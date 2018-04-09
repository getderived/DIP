clear all; close all; clc
a = imread('figuresmodified.bmp');
ee=strel('square', 3);
b=imerode(a,ee);
c=a-b;
figure(1);imshow([a,b,c]); 
figure(2);imshow(c);