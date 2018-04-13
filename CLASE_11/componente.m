%Se asume que viene de chori
function b = componente(a, c);
[fil, col] = size(a);
if c == 1; ind=1:col/3; end
if c == 2; ind=(col/3)+1:(col/3)*2; end
if c == 3; ind=(col/3)*2+1; col; end
b=a(:, ind);
end
