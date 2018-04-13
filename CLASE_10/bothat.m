clear all, close all, clc         
original = imread('pout.tif');
       se = strel('disk',3);
       contrastFiltered = ...
          imsubtract(imadd(original,imtophat(original,se)),...
                           imbothat(original,se));
       figure, imshow(original)
       figure, imshow(contrastFiltered)