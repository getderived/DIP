clear all, close all, clc
a=imread('beans.JPG');
%Ecualizar el histograma:
b=histeq(a);
figure(1);subplot 221;imshow(a);subplot 222;imhist(a);
%figure(2); 
subplot 223;imshow(b);subplot 224;imhist(b); %subplot means (2filas 2columnas 1 (se lo llevo  ala imagen 1) 2(se lo llevo a la imagen 2)