clear all;close all;clc;
a = videoinput('winvideo', 1, 'MJPG_640x480');
datos=[];
for i=1:10
    b=getsnapshot(a);c=getsnapshot(a);
    d=b-c;suma=sum(d(:)); datos=[datos, suma]; %it can be written as (SUM(SUM(SUM(d))). But not efficiently
    figure(1);imshow(d);
    title(['suma = ',num2str(suma)]);
    pause(0.001)
end
figure(2);plot(datos);