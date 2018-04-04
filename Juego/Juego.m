clear all, close all, clc
objects = imaqfind; %find video input objects in memory
delete(objects); %delete a video input object from memory

image = videoinput('winvideo', 1, 'YUY2_640x480'); %Le agrego la característica
set(image,'ReturnedColorSpace','rgb');
set(image,'TriggerRepeat',Inf);

% Define thresholds for channel 1 based on histogram settings
hMin = 0.542;
hMax = 0.602;

% Define thresholds for channel 2 based on histogram settings
sMin = 0.406;
sMax = 0.697;

% Define thresholds for channel 3 based on histogram settings
vMin = 0.404;
vMax = 0.757;

%Inicialización parámetros del juego
puntaje=0;
nivel=1;
vel=5;

l=200;%tamaño inicial canasta.
diam=50;%diametro de las bolas.
xnew=ceil((640-diam)*rand());%posición horizontal bola inicial
circulos=[xnew,-diam,diam,diam];%creación de bola inicial

boolean=1;
loose=1;

start(image);

while boolean
    while loose
        menu_img = getsnapshot(image);
        menu_img = flip(menu_img,2);
        figure(1); imshow(menu_img);
        hold on
        
        menu_s=[0,380,150,100];
        menu_h=rectangle('Position',menu_s,'FaceColor','g','EdgeColor','r');
        text(35,420,'START','Color','b','FontSize', 14);
        
        menu_q=[490,380,150,100];
        menu_p=rectangle('Position',menu_q,'FaceColor','r','EdgeColor','g');
        text(535,420,'QUIT','Color','w','FontSize', 14);
       
        menu_sc=rectangle('Position',[256,0,128,25],'FaceColor','w','EdgeColor','black');
        score=strcat('SCORE: ',num2str(puntaje));
        text(270,10,score,'Color','black','FontSize', 14);
        
        menu_I = rgb2hsv(menu_img);
        menu_objBin=(menu_I(:,:,1) >= hMin ) & (menu_I(:,:,1) <= hMax) & ...
        (menu_I(:,:,2) >= sMin ) & (menu_I(:,:,2) <= sMax) & ...
        (menu_I(:,:,3) >= vMin ) & (menu_I(:,:,3) <= vMax);
%         menu_r = menu_img(:,:,1);%Red layer.
%         menu_g = menu_img(:,:,2);%Green layer.
%         menu_b = menu_img(:,:,3);%Blue layer.
%         menu_blue = menu_b - menu_r/2 -  menu_g/2;
%         menu_objBin = menu_blue > 53;%Defines which pixels are blue.
        menu_img = bwareaopen(menu_objBin, 1000);%Extracts the areas of "blue" pixels (objects) that are bigger than 1000 pixels
        menu_o  = regionprops(menu_img, {'centroid','area'});%Obtenemos la11s propiedades 'centroide' y 'área' de cada objeto que este blanco en BW
        if isempty(menu_o)%Condicional que se encargará de reconocer si el vector con objetos 
        %que cumplen con la mascara de reconocimiento, se encuentra vacio.
        else
            [~, id] = max([menu_o.Area]);  %Obtenemos el ID del objeto cuya área sea la mayor en el vector de objetos
            menu_x = menu_o(id).Centroid(1)-15;%Coordenada en X para el CUADRO que identificará al jugador
            menu_y = menu_o(id).Centroid(2)-15;
            menu_c = [menu_x, menu_y, 30, 30];
            circle(menu_c);
            if bboxOverlapRatio(menu_s,menu_c)>0
                loose=0;
                puntaje=0;
                nivel=1;
                vel=5;

                l=200;%tamaño inicial canasta.
                xnew=ceil((640-diam)*rand());%posición horizontal bola inicial
                circulos=[xnew,-diam,diam,diam];%creación de bola inicial
            end
            if bboxOverlapRatio(menu_q,menu_c)>0
                loose=0;
                boolean=0;
                clear all, close all, clc
                objects = imaqfind; %find video input objects in memory
                delete(objects);
                break
            end
        end
        hold off
    end
    img = getsnapshot(image);%snapshot.
    img = flip(img,2);%flip image horizontally. Mirror effect.
    figure(1); imshow(img);
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
    

    
%     r = img(:,:,1);%Red layer.
%     g = img(:,:,2);%Green layer.
%     b = img(:,:,3);%Blue layer.
%     blue = b - r/2 -  g/2;
%     objBin = blue > 53;%Defines which pixels are blue.
    I = rgb2hsv(img);
    objBin=(I(:,:,1) >= hMin ) & (I(:,:,1) <= hMax) & ...
    (I(:,:,2) >= sMin ) & (I(:,:,2) <= sMax) & ...
    (I(:,:,3) >= vMin ) & (I(:,:,3) <= vMax);
    img = bwareaopen(objBin, 1000);%Extracts the areas of "blue" pixels (objects) that are bigger than 1000 pixels
%     figure(2); imshow(img);
    s  = regionprops(img, {'centroid','area'});%Obtenemos la11s propiedades 'centroide' y 'área' de cada objeto que este blanco en BW
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
                circulos=[circulos;[xnew,-diam,diam,diam]];
            end
            xnew=ceil((640-diam)*rand());
            circulos=[circulos;[xnew,-diam,diam,diam]];
        end
    end
    hold off
end
