clear all, close all, clc
a=imread('figures2.bmp');
b=bwmorph(a,'skel', Inf);
figure(1);imshow(a);
figure(2);imshow(b);