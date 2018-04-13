clear all, close all, clc
for i=1:104
    try
        img=strcat('lunares/',sprintf('%03d',i),'.jpg');
        a=imread(img);[fil,col,cap]=size(a);
        cform=makecform('srgb2lab');lab=applycform(a,cform);
        b=lab(:,:,3);lvl=graythresh(b); b=im2bw(b,lvl)*255;
        s=rgb2hsv(a);s=s(:,:,2);lvl=graythresh(s); s=im2bw(s,lvl)*255;
        b=min(s,b);
        ee=strel('square', 10);
        b=bwareaopen(b,1000);
        b=imclose(b,ee);
        b=uint8(b);b=imfill(b);
        b=[b,b,b];b=reshape(b,[fil,col,cap]);
        c=a;c(b==0)=0;
        figure(1);imshow([a,c]);
        title(strcat(sprintf('%03d',i),'.jpg'))
        pause
    end
end