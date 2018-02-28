clear all, close all, clc,
vidObj = VideoWriter('fundido.avi');
open(vidObj); %Abre objeto para guardar frames
a=imread('paisaje.jpg');b=imread('carwithoutgirls.jpg');
[fil,col,cap]=size(a);
c=imresize(b,[fil col]);
d=a+c;e=a/2+c/2;f=(a+c)/2;
figure(1);imshow([a, c; e,f]);
for i=0:0.01:1
    g=a*i +c*(1-i);
    figure(2);imshow(g);impixelinfo;
    currFrame = getframe;
    writeVideo(vidObj,currFrame);
    pause(0.01);
end
for i=1:-0.01:0
    g=a*i +c*(1-i);
    figure(2);imshow(g);impixelinfo;
    currFrame = getframe;
    writeVideo(vidObj,currFrame);
    pause(0.01);
end
close(vidObj);
