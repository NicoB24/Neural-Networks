% Ej-3
clear all;
clc;

%Elijo el numero de neuronas y el numero de patrones
N_neuronas=1000;
N_patrones=105;
%Cada una de las columnas de la siguiente matriz es un patron aleatorio
P=signo(randn(N_neuronas,N_patrones));
%Calculo la matriz W
W=(P*P')-(N_patrones*eye(N_neuronas));

%Realizo desconexiones entre neuronas, para eso pego 0s
A=rand(N_neuronas)>0.1; %Elijo para poner porcentaje de ceros, con 1 pongo 100% de ceros y deberia dar 0.5
W2=W.*A;

%Calculo el error (ingreso con mis patrones eps=sign(W*patron), veo que obtengo y hago la
%resta con el patron que ingrese error=eps-patron)
matriz_salidas=signo(W2*P);
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

error_final=sum(error_patron)/N_patrones