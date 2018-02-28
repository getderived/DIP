clear all;close all;clc;
a = videoinput('winvideo', 1, 'MJPG_640x480');
for i=1:20
    b=getsnapshot(a);c=getsnapshot(a);
    figure(1);imshow(b-c);
    pause(0.01)
end