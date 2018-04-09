%--------------------------------------------------------------------------
%------- Juego de bloques - PDI -------------------------------------------
%-Por: Jerónimo Alzate Duque  jeronimo.alzate@udea.edu.co CC 1152463262----
%   Nicolás Alberto Henao Avendaño nalberto.henao@udea.edu.co CC 1019120246
%------- Curso Básico de Procesamiento de Imágenes y Visión Artificial-----
%------- Abril de 2018-----------------------------------------------------
%--------------------------------------------------------------------------

clear all,close all,clc
objects = imaqfind; %find video input objects in memory
delete(objects); %delete a video input object from memory

image = videoinput('winvideo', 1, 'YUY2_640x480'); %Add characteristic
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

%Init game parameters
puntaje=0;
nivel=1;
vel=5;

diam=50;%ball diamater.

boolean=1;
loose=1;

start(image);

while boolean
    while loose
        menu_img = getsnapshot(image);
        menu_img = flip(menu_img,2); % Mirror effect
        figure(1); imshow(menu_img);
        hold on
        
        %Creation of the elements of the menu.
        
        menu_s=[0,380,150,100];  %Creation of START element
        menu_h=rectangle('Position',menu_s,'FaceColor','g','EdgeColor','r');
        text(35,420,'START','Color','b','FontSize', 14);
        
        menu_q=[490,380,150,100]; % Creation of QUIT element.
        menu_p=rectangle('Position',menu_q,'FaceColor','r','EdgeColor','g');
        text(535,420,'QUIT','Color','w','FontSize', 14);
       
        menu_sc=rectangle('Position',[256,0,128,25],'FaceColor','w','EdgeColor','black'); %Creation of last game SCORE element.
        score=strcat('SCORE: ',num2str(puntaje));
        text(270,10,score,'Color','black','FontSize', 14);
        
        menu_I = rgb2hsv(menu_img); 
        menu_objBin=(menu_I(:,:,1) >= hMin ) & (menu_I(:,:,1) <= hMax) & ...
        (menu_I(:,:,2) >= sMin ) & (menu_I(:,:,2) <= sMax) & ...
        (menu_I(:,:,3) >= vMin ) & (menu_I(:,:,3) <= vMax); %Analyzes the image from HSV with the defined Thresholds above to get the object. (in this case, blue objects)
        
        menu_img = bwareaopen(menu_objBin, 1000);%Extracts the areas of "blue" pixels (objects) that are bigger than 1000 pixels
        menu_o  = regionprops(menu_img, {'centroid','area'});%Get 'centroid' & 'area' properties from each objects that's white in black and white.
        if isempty(menu_o)%Checks if the vector with objects has elements to detect.
        else
            [~, id] = max([menu_o.Area]);  %Get the object's index wich area is biggest.
            menu_x = menu_o(id).Centroid(1)-15; %X axe of the menu cursor which identifies the player.
            menu_y = menu_o(id).Centroid(2)-15; %Y axe of the menu cursor  which identifies the player.
            menu_c = [menu_x, menu_y, 30, 30]; % Defines the position of the menu cursor.
            circle(menu_c);
            if bboxOverlapRatio(menu_s,menu_c)>0
                loose=0;
                puntaje=0;
                nivel=1;
                vel=5;

                l=200;%Initial basket size.
                xnew=ceil((640-diam)*rand());%horizontal position of initial ball
                circulos=[xnew,-diam,diam,diam];%creation initial ball
            end
            if bboxOverlapRatio(menu_q,menu_c)>0
                loose=0;
                boolean=0;
                objects = imaqfind; %find video input objects in memory
                delete(objects);
                clear all, close all, clc
                break
            end
        end
        hold off
    end
    img = getsnapshot(image);%snapshot.
    img = flip(img,2);%flip image horizontally. Mirror effect.
    figure(1); imshow(img);
    hold on
    elm=circulos(puntaje+1,:); %Finds the first ball
    gray(elm); % Paints the ball to be catched in a different color.
    elm(2)=elm(2)+vel; % The ball moves downwards.
    if elm(2)>480 %Delimits the size of the game space.
        loose=1;
    end
    circulos(puntaje+1,:)=elm; %Updates the ball parameters
    for i = puntaje+2:size(circulos,1) %creates the other balls in case there's more than one in that level.
        elm=circulos(i,:);
        circle(elm);
        elm(2)=elm(2)+vel;
        if elm(2)>480
            loose=1;
        end
        circulos(i,:)=elm;
    end
    
    
    I = rgb2hsv(img); %Converts rgb to hsv format.
    objBin=(I(:,:,1) >= hMin ) & (I(:,:,1) <= hMax) & ...
    (I(:,:,2) >= sMin ) & (I(:,:,2) <= sMax) & ...
    (I(:,:,3) >= vMin ) & (I(:,:,3) <= vMax); %Analyzes the image from HSV with the defined Thresholds above to get the object. (in this case, blue objects)
          
img = bwareaopen(objBin, 1000);%Extracts the areas of "blue" pixels (objects) that are bigger than 1000 pixels
    s  = regionprops(img, {'centroid','area'});%Get 'centroid' & 'area' properties from each objects that's white in black and white.
    if isempty(s)%Checks if the vector with objects has elements to detect.
        
    else
        hold on
        [~, id] = max([s.Area]);  %Get the object's ID which area is biggest.
        x = s(id).Centroid(1) - l/2;%X axe for the basket
        y = s(id).Centroid(2) - 15; %Y axe for the basket
        p = [x, y, l, 30]; % creates the basket.
        r = rectangle('Position',p,'EdgeColor','r','FaceColor','r'); % Paints the basket.
        if atrapar(circulos(puntaje+1,:),p)==1 % if the basket catches the ball.
            puntaje=puntaje+1; 
            if mod(puntaje,5*nivel*(nivel+1)/2)==0 %In case it gets 5*level balls, then level up.
                nivel = nivel + 1;
                vel = vel+1;
                if l>80 %To make sure the basket doesn't get smaller than 80px. In each level it gets smaller.
                    l=l-15;
                end
                xnew=ceil((640-diam)*rand()); %Random position of new additional ball.
                circulos=[circulos;[xnew,-diam,diam,diam]]; % adds it to the ball list.
            end
            xnew=ceil((640-diam)*rand()); %Random position of new ball when a ball is catched.
            circulos=[circulos;[xnew,-diam,diam,diam]]; %adds it to the ball list.
        end
    end
    hold off % Stop the overlapping plots.
end