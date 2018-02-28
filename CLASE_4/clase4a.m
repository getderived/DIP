clear all, close all, clc
a=imread('carbmp.bmp'); c=imread('paisaje.jpg');
b=rgb2gray(a);b1=b;bN=b; a1=a;
figure(1);imshow(a);impixelinfo
figure(2);imshow(b);impixelinfo
d=b*0; [fil,col,cap]=size(a);
d(fil/2:fil*3/4,col/2:col*3/4,:)=255; %Creo un cuadro blanco en un cuadro negro mayor(d)
figure(3);imshow(d);impixelinfo
%figure(4);imshow(and(d,b));
%ind2=find(d>0);
%bN(ind2)=0;
%figure(5);imshow(bN);
ind=find(d==0);
b1(ind)=0;
figure(4);imshow(b1);
b2=[d,d,d];
b2=reshape(b2,[fil col cap]);
figure(5);imshow(b2);impixelinfo
ind2=find(b2==0);
a1(ind2)=0;
figure(6);imshow(a1);impixelinfo