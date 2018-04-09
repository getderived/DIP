clear all; close all; clc
a = imread('figuresmodified.bmp');
ee = strel ('square', 3);
for i = 1: 10
    a=imdilate(a,ee); 
    figure(1);
    imshow(a);
end
pause(0.001)
for i= 1:10
    a=imerode(a,ee);
    figure(1);imshow(a);
    pause(0.01)
end
ee=strel ('square', 30);
a=imread('figuresmodified.bmp');
b=imclose(a,ee);
figure(2);imshow(b);
c=imopen(a,ee)
figure(3);imshow(c);