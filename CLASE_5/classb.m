clear all, close all, clc
a=imread('carbmp.bmp'); a= rgb2gray(a);
figure(1);imshow(a);impixelinfo;
figure(2);imhist(a);
b=a;
%Umbral:
b(b<190)=0; b(b>210)=0; 
%Binarizamos: 
b(b>0)=255;  %Para borrar el ruido de la imagen, se hará segmentación, que se puede aplicar con la
%Siguiente función:b=bwareaopen(b,50);

b=bwareaopen(b,50);

figure(3);imshow(b); impixelinfo;