% Ej-3
clear all;
clc;

%Elijo el numero de filas y columnas del estado inicial
filas=10;
columnas=10;
%Energia y 
Configuraciones=[];
E=[];
%Creo la matriz que representa el estado aleatorio inicial
P=signo(randn(filas,columnas));

%Comienzo el algoritmo (Elijo una temperatura)
    T=3;
    for w=1:10
        %Genero un vector aleatorio
        pos_aleatoria=randperm(filas*columnas);

        %Calculo la energia inicial
        energia=calcular_energia(P);

        %Recorro aleatoriamente la matriz y realizo cambios;
        for k=1:length(pos_aleatoria)
            %Tomo posicion aleatoria y cambio el elemento
            [i,j]=ind2sub(filas,pos_aleatoria(k));
            P=cambiar_elemento(P,i,j);
            %Recalculo la energia y calculo el delta de energia
            energia_nueva=calcular_energia(P);
            delta_energia=energia_nueva-energia;
            %Si el delta de energia es menor que 0 acepto el cambio, sino regla de
            %decision siguiente
            if(delta_energia<=0)
                energia=energia_nueva;
            elseif(delta_energia>0)
                if(exp(-1*delta_energia/T) >rand)
                    energia=energia_nueva;
                else
                    P=cambiar_elemento(P,i,j);
                end
            end
              
        end
        Configuraciones(:,:,w)=P;
        E=[E;energia];
    end

    %Busco la minima energia que haya tenido
    [valor,indice]=min(E)
    %La configuracion de menor energia sera
    Configuraciones(:,:,indice)