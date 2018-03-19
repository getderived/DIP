clear all, close all, clc
objects = imaqfind %find video input objects in memory
delete(objects) %delete a video input object from memory

image = videoinput('winvideo', 1, 'YUY2_640x480'); %Le agrego la caracter�stica
set(image,'ReturnedColorSpace','rgb');
% set(image,'FramesPerTrigger',1); Esto pa' qu� sirve??
set(image,'TriggerRepeat',Inf);


start(image);






while(1)
    cdt0 = getsnapshot(image);%snapshot.
    cdt = flip(cdt0,2);%flip image horizontally. Mirror effect.
    figure(1); imshow(cdt);
    
    r = cdt(:,:,1);%Red layer.
    g = cdt(:,:,2);%Green layer.
    b = cdt(:,:,3);%Blue layer.
    blue = b - r/2 -  g/2;
    objBin = blue > 50;%Defines which pixels are blue.
    cdt = bwareaopen(objBin, 1000);%Extracts the areas of "blue" pixels (objects) that are bigger than 1000 pixels
    figure(2); imshow(cdt);
    s  = regionprops(cdt, {'centroid','area'});%Obtenemos la11s propiedades 'centroide' y '�rea' de cada objeto que este blanco en BW
    if isempty(s)%Condicional que se encargar� de reconocer si el vector con objetos 
        %que cumplen con la mascara de reconocimiento, se encuentra vacio.
    else
        [~, id] = max([s.Area]);  %Obtenemos el ID del objeto cuya �rea sea la mayor en el vector de objetos
        hold on
        x = s(id).Centroid(1) - 5;%Coordenada en X para el CUADRO que identificar� al jugador
        y = s(id).Centroid(2) - 5;
        p = [x, y, 13, 13];
        r = rectangle('Position',p,'EdgeColor','b','LineWidth',2);
    end
end