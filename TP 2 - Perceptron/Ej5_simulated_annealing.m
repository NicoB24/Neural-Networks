clear all;
clc;
%Trabajo practico 2
%Ejercicio 2 - XOR 2 entradas, simulated annealing
%Elijo la cantidad de entradas
n_entradas=2;
a = 0:(2^n_entradas)-1;
n_valores=length(a);

%Entradas
data_in=de2bi(a,'left-msb');
%Salidas
data_out=xor(data_in(:,1),data_in(:,2));
%Cambio los 0 por -1 en la entrada y en la salida
data_in(data_in==0)=-1;
data_out=double(data_out);
data_out(data_out==0)=-1;

%Incializo perceptrones
beta=1;
entradas=3;
neuronas=2;
salidas=1;
%W_in=[W11 W12 W13; W21 W22 W23]
W_in=rand(neuronas, entradas);
%W_out=[WS1 WS2 WS3]
W_out=rand(salidas, neuronas+1);

%Simulated annealing
k=0.01;
perturbacion_Win = 0.1;
perturbacion_Wout = 0.1;
T_i=10;
T_p=0.0005;

T=T_i;
while (T>0)
    %Calculo las salidas para las entradas
    %Vector de posiciones aleatorias
    pos=randperm(length(data_in(:,1)));
    
    ECM=0;
    y=zeros(length(data_out),1);
    for i=1:length(pos)
        %Tomo fila aleatoria de data_in y le concateno 1 por el modelo
        X=[data_in(pos(i),:) 1]';
        %h=[h1;h2]
        h=W_in*X;
        %v=[v1;v2;v3] donde v3=1 se lo concateno por el modelo
        v=[tanh(beta*h);1];
        hs=W_out*v;
        %Calculo la salida para esa fila de data_in
        y(pos(i))=tanh(hs*beta);
        ECM = ECM + (y(pos(i)) - data_out(pos(i)))^2;
    end
    ECM=ECM / 2;

    
    %Realizo las perturbaciones en las matrices de pesos de entrada y salida en posiciones aleatorias
    %Perturbo W_in
    W_in_new = W_in;
    [filas, columnas] = size(W_in);
    fila = floor(rand() * filas) + 1;
    columna = floor(rand() * columnas) + 1;
    W_in_new(fila, columna) = W_in_new(fila, columna) + randn() * perturbacion_Win;
    %Perturbo W_out
    W_out_new = W_out;
    [filas, columnas] = size(W_out);
    fila = floor(rand() * filas) + 1;
    columna = floor(rand() * columnas) + 1;
    W_out_new(fila, columna) = W_out_new(fila, columna) + randn() * perturbacion_Wout;
    
    
    %Calculo las salidas para la entrada dada pero con las perturbaciones
    %en las matrices de pesos de entrada y salida
    ECM_nuevo=0;
    y=zeros(length(data_out),1);
    for i=1:length(pos)
        %Tomo fila aleatoria de data_in y le concateno 1 por el modelo
        X=[data_in(pos(i),:) 1]';
        %h=[h1;h2]
        h=W_in_new*X;
        %v=[v1;v2;v3] donde v3=1 se lo concateno por el modelo
        v=[tanh(beta*h);1];
        hs=W_out_new*v;
        %Calculo la salida para esa fila de data_in
        y(pos(i))=tanh(hs*beta);
        ECM_nuevo = ECM_nuevo + (y(pos(i)) - data_out(pos(i)))^2;
    end
    ECM_nuevo=ECM_nuevo / 2;
    
    %Ahora debo ver si acepto el cambio o no
    if(ECM_nuevo <= ECM)
        W_in = W_in_new;
        W_out = W_out_new;
    else
        p = exp(-(ECM_nuevo - ECM) / T / k);
        if(rand < p)
        	W_in = W_in_new;
            W_out = W_out_new;
        end
    end

    %Disminuyo la temperatura
    T = T - T_p
    
end

disp('Error Cuadratico Medio:');
ECM
     
disp('Salidas:');
y=zeros(length(data_out),1);
  for i=1:length(pos)
        %Tomo fila aleatoria de data_in y le concateno 1 por el modelo
        X=[data_in(pos(i),:) 1]';
        %h=[h1;h2]
        h=W_in*X;
        %v=[v1;v2;v3] donde v3=1 se lo concateno por el modelo
        v=[tanh(beta*h);1];
        hs=W_out*v;
        %Calculo la salida para esa fila de data_in
        y(pos(i))=tanh(hs*beta);
  end
y

%Imprimo los datos y las rectas de decision
figure
hold on
plot(data_in(:,1),data_in(:,2),'o');
xlabel('X2')
ylabel('X1')
xlim([-2 2])
ylim([-2 2])
 
t = -4:4;
plot(t,(-W_in(1,1)/W_in(1,2))*t - W_in(1,3)/W_in(1,2));
plot(t,(-W_in(2,1)/W_in(2,2))*t - W_in(2,3)/W_in(2,2));
