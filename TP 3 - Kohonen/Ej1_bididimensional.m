clear all;
clc;
%Trabajo practico 3
%Ejercicio 1 - Kohonen 2 entradas

%Elijo parametros
entradas=2;
sigma=10;
n=0.1; %eta
sigma_paso=0.1;
cantidad_puntos=2000;
cantidad_neuronas_x=10;
cantidad_neuronas_y=10;

%Creo la distribución de puntos
center = [0,0];
radius = 1;
tita=2*pi*rand(1,cantidad_puntos);
r=radius*sqrt(rand(1,cantidad_puntos));
X = r.*cos(tita);
Y = r.*sin(tita);


%Creo la distribucion de pesos, en este caso son matrices
Wx=randn(cantidad_neuronas_x, cantidad_neuronas_y);
Wy=randn(cantidad_neuronas_x, cantidad_neuronas_y);


%Situacion Inicial
figure
hold on;
plot(X, Y,'xc')
plot(Wx,  Wy, 'r', 'LineWidth', 1)
plot(Wx', Wy','r', 'LineWidth', 1)
plot(Wx,  Wy, 'ob')
axis([-1.1 1.1 -1.1 1.1])
title('Situacion Inicial')



%Inicio del algoritmo
pos=randperm(length(X)); %Vector de posiciones al azar

while(sigma>0)   
 
    for i=1:length(X)
        
        %Elijo X e Y al azar
        X_rand=X(pos(i));
        Y_rand=Y(pos(i));
        
        %Busco la neurona ganadora, para eso le hago la resta a todos los
        %pesos de Wx y Wy de los valores de X e Y tomados al azar,y luego
        %calculo la distancia euclidea como sqrt(resta_x^2 + resta_y^2)
        %para cada elemento despues de la resta. Luego voy a buscar en
        %ambas matrices donde se produce la menor distancia, tanto para x
        %como para y, para sacar los indices de las neuronas ganadoras. d
        %es una matriz con todas las distancias
        d = sqrt(( (Wx-X_rand) .^ 2) + ( (Wy-Y_rand) .^ 2));
        [M,I] = min(d(:));
        [I_x, I_y] = ind2sub(size(d),I); %Donde I_x e I_y son las posiciones de la neurona ganadora
        indices_ganadores=[I_x, I_y];
        
        %Comienzo la actualización
        for i=1:cantidad_neuronas_x
            for j=1:cantidad_neuronas_y
                dist=(norm(indices_ganadores - [i j]))^2;
                funcion_vecindad=exp(-(dist) / (2*sigma^2));
                Wx(i,j)=Wx(i,j)+n*funcion_vecindad*(X_rand-Wx(i,j));
                Wy(i,j)=Wy(i,j)+n*funcion_vecindad*(Y_rand-Wy(i,j));
            end
        end
        
    end

    sigma=sigma-sigma_paso
 
end


%Situacion Final
figure
hold on;
plot(X, Y,'xc')
plot(Wx,  Wy, 'r', 'LineWidth', 2)
plot(Wx', Wy','r', 'LineWidth', 2)
plot(Wx,  Wy, 'ob')
axis([-1.1 1.1 -1.1 1.1])
title('Situacion Final')