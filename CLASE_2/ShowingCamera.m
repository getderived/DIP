clear all, close all, clc

% imaqhwinfo
% imaqhwinfo('winvideo')
% imaqhwinfo('winvideo', 1) %En caso de que hayan m�s devices
image = videoinput('winvideo', 1, 'MJPG_1280x720') %Le agrego la caracter�stica
preview(a) %Para lanzar la c�mara