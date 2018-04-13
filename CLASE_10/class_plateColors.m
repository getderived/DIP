clear all, close all, clc
a=imread('carro.jpg'); a=imresize(a,0.2);
ee=strel('square',7);
a=imdilate(a,ee);
[a1,a2,a3,a4,a5] = componentes(a);
% figure(1);imshow([a1;a2;a3]);impixelinfo
[fil,col,cap]= size(a);
s= a2(:, col+1:2*col); %La capa 2, comienza en col+1 y termina en col*2, la tercera columna empezaría en col*2+1 y terminaría en col*3
figure(1);imshow(s);impixelinfo
b=impixel;
umbral_min=min(b(:));
umbral_max=max(b(:));
s(s<umbral_min)=0;
s(s>0)=255;
figure(2);imshow(s);impixelinfo