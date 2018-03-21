function bool = atrapar(bola,canasta)
    if bboxOverlapRatio(bola,canasta) > 0
        px=bola(1);
        d=bola(3);
        x=canasta(1);
        l=canasta(3);
        if px>x && px<(x+l) && x< px+0.75*d && px+0.75*d < x+l %para verificar que la bola esté dentro del rango de la canasta. Se decide que para que la bola entre en la canasta, debe entrar mínimo un 75%. (x<px<x+l  && x<px+.75d<x+l)
            bool=1;
            return
        end
        if px+d>x && px+d<(x+l) && x< px+0.25*d && px+0.25*d < x+l %para verificar que la bola esté dentro del rango de la canasta. Se decide que para que la bola entre en la canasta, debe entrar mínimo un 75%. (x<px+d<x+l  && x<px+.25d<x+l)
            bool=1;
        else
            bool=0;
        end
    else
        bool=0;
    end
end

