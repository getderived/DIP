clear all;close all;clc;
a=imread('rgb2.png');
figure(1);imshow(a);impixelinfo
b=rgb2gray(a);[fil,col]=size(b);
figure(2);imshow(b);impixelinfo;
C=[b,b,b];
figure(3);imshow(C);impixelinfo;
d=reshape(C,[fil, col, 3]);
figure(4);imshow(d);impixelinfo
e=reshape(a,[fil,col*3]);
figure(5);imshow(e);impixelinfo
