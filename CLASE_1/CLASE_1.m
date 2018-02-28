clear all;
close all;
clc;
a=imread('rgb.png');
figure(1);imshow(a);impixelinfo; %Es para mostrar la imagen con la info en el footer
r=a; g=a; b=a;
r(:,:,2:3)=0;%Destruye capa 2 y 3 para mostrar la capa 1, roja.
figure(2);imshow(r);impixelinfo;
g(:,:,1:2:3)=0; %Destruye capa 1 y 3 para que quede solo la 2.
b(:,:,1:2)=0; %Destruye capa 1 y 2 para que quede solo la 3.
figure(3);imshow(g);impixelinfo;
figure(4);imshow(b);impixelinfo;
figure(5);subplot(2,2,1); %2 filas, 2 columas en la pos 1
imshow(a);
subplot 222;imshow(r);
subplot 223;imshow(g);
subplot 224;imshow(b);impixelinfo;
t=[a,r;g,b];
figure;imshow(t);impixelinfo;