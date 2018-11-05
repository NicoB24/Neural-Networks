clear all;
clc;
%Trabajo practico 2
%Ejercicio 3 - f(x,y,z)}

separacion = 10;
%Genero las muestras de f(x,y,z);
[data_in,data_out]=generar_muestras(separacion);


%Incializo perceptrones
beta=0.5;
n=0.01;
entradas=4;
salidas=1;
neuronas=5;
%W_in=[W11 W12 W13; W21 W22 W23; ....]
W_in=rand(neuronas, entradas);
%W_out=[WS1 WS2 WS3 ...]
W_out=rand(salidas, neuronas+1);
y_calculado = zeros(length(data_out),1);


while (immse(data_out,y_calculado) > 0.0025)
    %Vector de posiciones aleatorias
    pos=randperm(length(data_in(:,1)));

    for i=1:length(pos)
        %Tomo fila aleatoria de data_in y le concateno 1 por el modelo
        X=[data_in(pos(i),:) 1]';
        %h=[h1;h2]
        h=W_in*X;
        %v=[v1;v2;v3] donde v3=1 se lo concateno por el modelo
        v=[tanh(beta*h);1];
        hs=W_out*v;
        %Calculo la salida para esa fila de data_in
        y=tanh(hs*beta);
    
        %Calculo los delta
        delta_s=g_prima(hs,beta)*(data_out(pos(i)) - y);
        delta_12=delta_s*g_prima(h,beta).*W_out(1:neuronas)';
    
        %Recalculo W
        W_out= W_out + n*delta_s*v';
        W_in= W_in + n*delta_12*X';
    end

y_calculado=perceptron_out(W_in,W_out,data_in,beta);
immse(data_out,y_calculado)
end

hold on
plot(y_calculado)
plot(data_out)
legend('y','yd','Location','southeast')