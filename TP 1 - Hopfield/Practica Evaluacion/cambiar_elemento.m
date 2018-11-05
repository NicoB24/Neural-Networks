function [ P ] = cambiar_elemento( P, i, j )

if (P(i,j)==1)
    P(i,j)=-1;
elseif (P(i,j)==-1)
    P(i,j)=1;
end

