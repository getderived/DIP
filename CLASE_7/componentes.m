function [a1, a2, a3, a4, a5] = componentes(a)
%DIFFERENT TYPES OF COLOR FORMATS . USE makecform TO CHANGE IT.
%'lab2lch'   'lch2lab'   'upvpl2xyz'   'xyz2upvpl'  
%'uvl2xyz'   'xyz2uvl'   'xyl2xyz'     'xyz2xyl'
%'xyz2lab'   'lab2xyz'   'srgb2xyz'    'xyz2srgb'
%'srgb2lab'  'lab2srgb'  'srgb2cmyk'   'cmyk2srgb'
a1=chori(a);
a2=rgb2hsv(a);
a2=chori(a2);
cform=makecform('srgb2cmyk');
a3= applycform(a,cform); k = a3(:,:,4);
a3=chori(a3(:,:,1:3)); %(Convierta a chori las 3 primeras capas)
a4=[k,k,k];
cform2 = makecform('srgb2lab');
a5= applycform(a,cform2);
a5= chori(a5);
end


