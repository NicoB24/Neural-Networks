clear all;
clc;
%Trabajo practico 3
%Ejercicio 1 - Kohonen 2 entradas

%Elijo parametros
entradas=2;
sigma=10;
n=1; %eta
sigma_paso=0.1;
cantidad_puntos=200;
cantidad_neuronas=50;

%Creo la distribución de puntos
radio=1;
x_centro=0;
y_centro=0;
[ X,Y ] = uniform_circle( radio,cantidad_puntos,x_centro,y_centro);
XY=[X Y];

%4 Clusters
% [X1,Y1]=circle_contourn(radio,50,5,5);
% XY1=[X1 Y1];
% [X2,Y2]=circle_contourn(radio,50,-5,-5);
% XY2=[X2 Y2];
% [X3,Y3]=circle_contourn(radio,50,5,-5);
% XY3=[X3 Y3];
% [X4,Y4]=circle_contourn(radio,50,-5,5);
% XY4=[X4 Y4];
% X=[X1;X2;X3;X4];
% Y=[Y1;Y2;Y3;Y4];
% XY=[X Y];

%Creo la distribucion de pesos
W=randn(cantidad_neuronas, entradas);

figure 
plot(X,Y,'bo')
hold on
plot(W(:,1),W(:,2),'ro')
%xlim([-10 10])
%ylim([-10 10])
title('Estado antes del entrenamiento')
legend('Distribución deseada','Pesos iniciales','Location','southeast')


%Inicio del algoritmo
pos=randperm(length(XY(:,1)));

while(sigma>0)
    for i=1:length(XY(:,1))
        %Elijo posicion XY al azar
        XY_rand=XY(i,:);
        %Busco la neurona ganadora
        distancias=[];
        for i=1:length(W)
            resta=W(i,:)-XY_rand;
            norm_resta=norm(resta);
            distancias=[distancias norm_resta];
        end

        %Busco el indice de la neurona ganadora
        [M,i_ganadora] = min(distancias);

        %Actualizo W
        for i=1:length(W)
            i_ig=(abs(i-i_ganadora))^2;
            funcion_vecindad=exp(-i_ig / (2*sigma^2));
            delta_W=n*funcion_vecindad*(XY_rand-W(i,:));
            W(i,:)=W(i,:)+delta_W;
        end
    end
    sigma=sigma-sigma_paso
end

figure
plot(X,Y,'bo')
hold on
plot(W(:,1),W(:,2),'ro')
%xlim([-10 10])
%ylim([-10 10])
title('Estado despues del entrenamiento')
legend('Distribución deseada','Pesos modificados','Location','southeast')
