function bool = atrapar( bola, canasta)
    if (bboxOverlapRatio(bola,canasta) == 1)
        if (bola(1)>canasta(1) && bola(1)<(canasta(1)+canasta(3)) && canasta(1)< bola(1)+0.75*bola(3) && bola(1)+0.75*bola(3) < canasta(1)+canasta(3)) %para verificar que la bola esté dentro del rango de la canasta. Se decide que para que la bola entre en la canasta, debe entrar mínimo un 75%. (x<px<x+l  && x<px+.75d<x+l)
            bool=1;
            return
        end
        if (bola(1)+bola(3)>canasta(1) && bola(1)+bola(3)<(canasta(1)+canasta(3)) && canasta(1)< bola(1)+0.25*bola(3) && bola(1)+0.25*bola(3) < canasta(1)+canasta(3))%para verificar que la bola esté dentro del rango de la canasta. Se decide que para que la bola entre en la canasta, debe entrar mínimo un 75%. (x<px+d<x+l  && x<px+.25d<x+l)
            bool=1;
        else
            bool=0;
        end
    else
        bool=0;
    end
end

