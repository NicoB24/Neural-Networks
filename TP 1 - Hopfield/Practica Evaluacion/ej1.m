% Ej-1
clear all;
clc;

%Elijo el numero de neuronas y el numero de patrones (hasta lograr Perror
%deseada)
N_neuronas=1000;
N_patrones=150;
%Cada una de las columnas de la siguiente matriz es un patron aleatorio
P=signo(randn(N_neuronas,N_patrones));
%Calculo la matriz W
W=(P*P')-(N_patrones*eye(N_neuronas));
%Calculo el error (ingreso con mis patrones eps=sign(W*patron), veo que obtengo y hago la
%resta con el patron que ingrese error=eps-patron)
matriz_salidas=signo(W*P);
matriz_errores=P-matriz_salidas;

error_patron=[];
dato=0;
for j=1:N_patrones
    for i=1:N_neuronas
        if (matriz_errores(i,j)~=0)
            dato=dato+1;
        end
    end
    error_patron=[error_patron; dato/N_neuronas];
    dato=0;
end

error_final=sum(error_patron)/N_patrones;