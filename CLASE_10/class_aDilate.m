clear all, close all, clc
a=imread('carro.jpg'); a=imresize(a, 0.2);
ee=strel('square', 3);
b=chori(a);
for i=1:20
    a=imdilate(a,ee); b=imdilate(b,ee);
    figure(1);imshow(a);
    figure(2);imshow(b);
    pause
end