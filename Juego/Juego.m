clear all, close all, clc
objects = imaqfind %find video input objects in memory
delete(objects) %delete a video input object from memory

image = videoinput('winvideo', 1, 'YUY2_640x480'); %Le agrego la característica
set(image,'ReturnedColorSpace','rgb');
% set(image,'FramesPerTrigger',1); Esto pa' qué sirve??
set(image,'TriggerRepeat',Inf);

%Inicialización parámetros del juego
puntaje=0;
circulos=[[150,0,50];[340,20,10]];
x=150;
y=0;
radio=50;

start(image);


while(1)
    cdt0 = getsnapshot(image);%snapshot.
    cdt = flip(cdt0,2);%flip image horizontally. Mirror effect.
    figure(1); imshow(cdt);
    hold on
    for i = 1:size(circulos,1)
        elm=circulos(i,:);
        circle(elm(1),elm(2),elm(3));
        elm(2)=elm(2)+5;
        circulos(i,:)=elm;        
    end
    hold off
    
    
    
    r = cdt(:,:,1);%Red layer.
    g = cdt(:,:,2);%Green layer.
    b = cdt(:,:,3);%Blue layer.
    blue = b - r/2 -  g/2;
    objBin = blue > 53;%Defines which pixels are blue.
    cdt = bwareaopen(objBin, 1000);%Extracts the areas of "blue" pixels (objects) that are bigger than 1000 pixels
%     figure(2); imshow(cdt);
    s  = regionprops(cdt, {'centroid','area'});%Obtenemos la11s propiedades 'centroide' y 'área' de cada objeto que este blanco en BW
    if isempty(s)%Condicional que se encargará de reconocer si el vector con objetos 
        %que cumplen con la mascara de reconocimiento, se encuentra vacio.
    else
        hold on
        [~, id] = max([s.Area]);  %Obtenemos el ID del objeto cuya área sea la mayor en el vector de objetos
        x = s(id).Centroid(1) - 5;%Coordenada en X para el CUADRO que identificará al jugador
        y = s(id).Centroid(2) - 5;
        p = [x, y, 13, 13];
        r = rectangle('Position',p,'EdgeColor','r','LineWidth',2);
    end
end
function circle(x,y,r)
    d=r*2;
    px=x-r;
    py=y-r;
    h=rectangle('Position',[px py d d], 'Curvature', [1,1],'FaceColor',[0.6 0 1]);
    daspect([1,1,1])
end
