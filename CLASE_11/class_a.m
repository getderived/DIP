clear all, close all, clc
a=imread('084.jpg');
[a1,a2,a3,a4,a5]= componentes(a);
figure(1);imshow([a1;a2;a3;a4;a5]); impixelinfo
title(['rgb -hsv - cmy - kkk - lab']) %Se observa que la b de rgb, s, y y la b1 de lab, determinan el lunor melo.
s=componente(a2, 2);
b=componente(a1),3