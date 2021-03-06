clear all, close all, clc
a=imread('carro.jpg'); a=imresize(a,0.2);
[a1,a2,a3,a4,a5] = componentes(a);
figure(1);imshow([a1;a2;a3]);
figure(2); imshow([a4; a5]);
[fil,col,cap]= size(a);
s= a2(:, col+1:2*col); %La capa 2, comienza en col+1 y termina en col*2, la tercera columna empezarķa en col*2+1 y terminarķa en col*3
b=a5(:,col*2+1:col*3);
y=a3(:,col*2+1:col*3);
figure(3);imshow([s,b,y]); impixelinfo
c1 = min(s, y);
c2 = min(s,b);
c3 = max (s, y);
c4 = max (s, b);
figure(4); imshow([c1,c2;c3,c4]);impixelinfo

c5= c1;
c5(c5<180)=0; c5(c5>0)=255;
figure(5); imshow(c5);
figure(6); imshow(a);

%Para diferenciar el color
c5= [c5, c5, c5];
c5= reshape(c5, [fil,col,cap]);
a(c5==0)= 0;
figure(7);imshow(a);