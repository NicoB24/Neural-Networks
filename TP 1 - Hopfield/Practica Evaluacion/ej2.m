% Ej-2
clear all;
clc;

%Elijo el numero de neuronas y el numero de patrones
N_neuronas=200;
N_patrones=10;
%Cada una de las columnas de la siguiente matriz es un patron aleatorio
P=signo(randn(N_neuronas,N_patrones));
%Calculo la matriz W
W=(P*P')-(N_patrones*eye(N_neuronas));

%Genero un patron aleatorio
patron=signo(randn(N_neuronas,1));

%Realizo desconexiones entre neuronas, para eso pego 0s
A=rand(N_neuronas)>0.5; %Elijo para poner porcentaje de ceros, con 1 pongo 100% de ceros
W2=W.*A;

%Realizo actualizacion asincronica y veo la energia (Si cambio W por W2 incluyo desconexiones)
[ vector_actualizado, energia ]= actualizacion_asincronica(W,patron);
plot(energia)
title('Energia vs iteracion')
ylabel('Energia')
xlabel('Iteracion')
