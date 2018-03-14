clear all; close all; clc
a1=imread('ElColombiano.JPG'); a2=rgb2gray(a1);
%Binarizo la imagen para poder que el plot me ayude a caracterizar cuáles
%son palabras y cuáles son letras.
a=a2; a(a<200)=0; a(a>0)=255; % Estamos tratando de hacer lo que sea medio gris 
figure(1);imshow(a);impixelinfo
b=a';
figure(2);imshow(b) 
c=sum(b);
figure(3); plot(c) %According with the changes in the lines, it determines how many lines there are.
d=a(23:36, :); figure(4); imshow(d) %With the X help, it
e=sum(d);
figure(5); plot(e)
f=d(:,336:412); %De acuerdo a el ancho de los picos máximos, puedo separar las palabras.
figure(6);imshow(f) 
g=sum(f);
figure(7); plot(g);
g=f(:, 5:11);
figure(8); imshow(g);
