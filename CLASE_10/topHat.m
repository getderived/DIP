clear all, close all, clc  
original = imread('rice.png');
    figure, imshow(original)
    se = strel('disk',12);
    tophatFiltered = imtophat(original,se);
    figure, imshow(tophatFiltered)
    contrastAdjusted = imadjust(tophatFiltered);
    figure, imshow(contrastAdjusted)
