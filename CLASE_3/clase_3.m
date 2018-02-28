clear all; close all; clc;
a=imread('paisaje.jpg');c=imread('carwithoutgirls.jpg');
figure(1); imshow(a);impixelinfo
b=255-a;[fil,col,cap]=size(a);
figure(2);imshow(b);impixelinfo
e=imresize(c,[fil col]);
d=a+e;
figure(3);imshow(d);
%for i=1:255
%    f=e-i;
%    figure(4);imshow(f);
%    pause(.01);
%end
