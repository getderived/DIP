%Script to understand the indice.

a=[1,2,3;4,5,6;7,8,9]
ind=find(a>5)
[x,y]=find(a>5) %Old school
a(:)
b=(a*0)
b(ind)=1