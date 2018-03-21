clear all, close all, clc
objects = imaqfind; %find video input objects in memory
delete(objects); %delete a video input object from memory

image = videoinput('winvideo', 1, 'YUY2_640x480'); %Le agrego la característica
set(image,'ReturnedColorSpace','rgb');
set(image,'TriggerRepeat',Inf);

%Inicialización parámetros del juego
puntaje=0;
nivel=1;
vel=5;

l=200;%tamaño inicial canasta.
diam=50;%diametro inicial bola.
xnew=ceil((640-diam)*rand());%posición horizontal bola inicial
circulos=[xnew,0,diam,diam];%creación de bola inicial

start(image);
boolean=1;
loose=1;

while(boolean)
    while loose
        cdt0 = getsnapshot(image);
        cdt = flip(cdt0,2);
        figure(1); imshow(cdt);
        hold on
        st=[0,380,150,100];
        h=rectangle('Position',st,'FaceColor','g','EdgeColor','r');
        text(35,420,'START','Color','b','FontSize', 14);
        
        qt=[490,380,150,100];
        p=rectangle('Position',qt,'FaceColor','r','EdgeColor','g');
        text(535,420,'QUIT','Color','w','FontSize', 14);
        
        
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
            x = s(id).Centroid(1) - l/2;%Coordenada en X para el CUADRO que identificará al jugador
            y = s(id).Centroid(2) - 15;
            ip = [x, y, l, 30];
            rec = rectangle('Position',ip,'EdgeColor','r','FaceColor','r');
            if bboxOverlapRatio(st,ip)>0
                loose=0;
            end
            if bboxOverlapRatio(qt,ip)>0
                loose=0;
                boolean=0;
                clear all, close all, clc
                objects = imaqfind; %find video input objects in memory
                delete(objects);
                break
            end
        end
    end
    cdt0 = getsnapshot(image);%snapshot.
    cdt = flip(cdt0,2);%flip image horizontally. Mirror effect.
    figure(1); imshow(cdt);
    hold on
    for i = puntaje+1:size(circulos,1)
        elm=circulos(i,:);
        circle(elm);
        elm(2)=elm(2)+vel;
        if elm(2)>480
            loose=1;
        end
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
        x = s(id).Centroid(1) - l/2;%Coordenada en X para el CUADRO que identificará al jugador
        y = s(id).Centroid(2) - 15;
        p = [x, y, l, 30];
        r = rectangle('Position',p,'EdgeColor','r','FaceColor','r');
        if atrapar(circulos(puntaje+1,:),p)==1
            puntaje=puntaje+1;
            if mod(puntaje,5*nivel*(nivel+1)/2)==0
                nivel = nivel + 1;
                vel = vel+1;
                if l>80
                    l=l-15;
                end
                xnew=ceil((640-diam)*rand());
                circulos=[circulos;[xnew,0,diam,diam]];
            end
            xnew=ceil((640-diam)*rand());
            circulos=[circulos;[xnew,0,diam,diam]];
        end
    end
end
