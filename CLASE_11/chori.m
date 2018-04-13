function b= chori(a)
[fil, col, cap] =size(a);
a=double(a); %Lets me make mathematical operations. If there are int.
a=a/max(a(:))*255;
b=uint8(a); 
b=reshape(b,[fil, col*cap]);
end