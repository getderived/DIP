clear all, close all, clc
a=imread('carro.jpg'); a=imresize(a, 0.33);
% figure(1); imshow(a); impixelinfo;
% b= rgb2hsv(a);
% figure(2);imshow(b);impixelinfo;
% [fil, col, cap] = size(a);
% a1=reshape(a, [fil,col*cap]); 
% figure(3);imshow(a1);impixelinfo
% c=reshape(b,[fil,col*cap]);
% figure(4);imshow(c);impixelinfo
[a1, a2, a3] =componentes(a);
figure(1); imshow(a1);
figure(2); imshow(a2);
figure(3);imshow([a1;a2]);
figure(4);imshow(a3);impixelinfo;