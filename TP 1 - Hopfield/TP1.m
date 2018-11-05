clear all;close all
%TP1

%% EJ-1
%En este caso la actualizacion es sincronica
%Cargo las imagenes
A=imread('casam.bmp');
B=imread('cielom.bmp');
C=imread('escaleram.bmp');
%Casteo las imagenes a double
A_double=double(A);
B_double=double(B);
C_double=double(C);
%Cambio los 0 por -1 para tener valores 1 o -1
A_double(A_double==0)=-1;
B_double(B_double==0)=-1;
C_double(C_double==0)=-1;
%Paso las matrices a vector columna
A_vector=A_double(:);
B_vector=B_double(:);
C_vector=C_double(:);

%Armo una matriz que tenga los patrones anteriores como columnas
P=[A_vector B_vector C_vector];
%Calculo la matriz W
W=(P*P')-(3*eye(2500,2500));

%Me fijo si aprendió el patrón (Las restas deben dar vectores nulos)
testA = sign(W*A_vector);
testB = sign(W*B_vector);
testC = sign(W*C_vector);
A_resta=testA-A_vector;
B_resta=testB-B_vector;
C_resta=testC-C_vector;

%Me fijo si reconoce patrones corruptos (con vec2mat lo paso a matriz)
C_corrupto=imread('escaleram_corrupto.bmp');
C_corrupto_double=double(C_corrupto);
C_corrupto_double(C_corrupto_double==0)=-1;
C_vector_corrupto=C_corrupto_double(:);
testC_corrupto = sign(W*C_vector_corrupto);
C_resta_corrupto=testC_corrupto-C_vector;


%Entro con alguna combinación y me fijo si es un estado estable (es decir,
%sale con lo que entro)
comb_vector=A_vector+B_vector+C_vector;
test_comb = sign(W* sign(A_vector+B_vector+C_vector) );
resta_comb=comb_vector-test_comb;


%% Ej2
clear all;
clc;

%Elijo el numero de neuronas y el numero de patrones
N_neuronas=1000;
N_patrones=370;
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

%% Ej3
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


%% Ej4
clear all;
clc;

%Elijo el numero de filas y columnas del estado inicial
filas=10;
columnas=10;
%Magnetizacion
M=[];
%Creo la matriz que representa el estado aleatorio inicial
P=signo(randn(filas,columnas));
%Elijo el rango de temperaturas en el que voy a trabajar
Temperaturas=linspace(6,0);

%Comienzo el algoritmo (Se le va disminuyendo la temperatura)
for temp=1:length(Temperaturas)
    T=Temperaturas(temp);
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
    end
    %Calculo la magnetizacion y la guardo en el vector M
    M1=sum(P);
    M_final=sum(M1);
    M=[M;M_final];
end

%Grafico M vs T
plot(Temperaturas,M)

  

