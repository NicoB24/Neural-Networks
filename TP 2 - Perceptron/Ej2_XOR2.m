clear all;
clc;
%Trabajo practico 2
%Ejercicio 2 - XOR 2 entradas
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
beta=0.5;
n=1;
entradas=3;
neuronas=2;
salidas=1;
%W_in=[W11 W12 W13; W21 W22 W23]
W_in=rand(neuronas, entradas);
%W_out=[WS1 WS2 WS3]
W_out=rand(salidas, neuronas+1);
y_calculado = zeros(length(data_out),1);


while (immse(data_out,y_calculado) > 0.0001)
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

y_calculado=perceptron_out(W_in,W_out,data_in,beta)

end

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
