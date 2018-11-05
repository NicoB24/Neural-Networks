%Nicolás Bruno - 95191
%Ejercicio 1 del parcial (Explicaciones en el script)
clear all
clc

%En este caso la actualizacion es sincronica
%Cargo las imagenes
A=imread('padrino.bmp');
B=imread('panda.bmp');
C=imread('perro.bmp');
D=imread('v.bmp');
%Casteo las imagenes a double
A_double=double(A);
B_double=double(B);
C_double=double(C);
D_double=double(D);
%Cambio los 0 por -1 para tener valores 1 o -1
A_double(A_double==0)=-1;
B_double(B_double==0)=-1;
C_double(C_double==0)=-1;
D_double(D_double==0)=-1;
%Paso las matrices a vector columna
A_vector=A_double(:);
B_vector=B_double(:);
C_vector=C_double(:);
D_vector=D_double(:);

%Armo una matriz que tenga los patrones anteriores como columnas
P=[A_vector B_vector C_vector D_vector];
%Calculo la matriz W
W=(P*P')-(4*eye(2500,2500));

%Me fijo si aprendió el patrón (Las restas deben dar vectores nulos)
testA = actualizacion_sincronica(W,A_vector);
testB = actualizacion_sincronica(W,B_vector);
testC = actualizacion_sincronica(W,C_vector);
testD = actualizacion_sincronica(W,D_vector);
A_comprobacion=isequal(testA,A_vector);
B_comprobacion=isequal(testB,B_vector);
C_comprobacion=isequal(testC,C_vector);
D_comprobacion=isequal(testD,D_vector);

%EXPLICACION: Para enseñarle a la red de Hopfield las 4 imagenes dadas, se
%leen las imagenes con imread, se las castea a double, se cambian los 0 por
%-1 y se pasan estas matrices a vector columna. Estos vectores, se colocan
%como columnas de la matriz P y se arma la matriz de pesos de Hopfield con
%la linea W=(P*P')-(4*eye(2500,2500)). Una vez obtenida esta matriz, se
%pasa a comprobar si las imagenes fueron aprendidas correctamente, para eso
%se utiliza actualización sincronica (mediante la funcion llamada
%actualizacion_sincronica). Cabe aclarar que la función signo es una
%función implementada para evitar la indeterminacion en 0 que tiene la
%funcion sign que ya viene con MATLAB. En la actualización sincronica se
%multiplica la matriz W por el vector deseado, se la aplica signo y se
%obtiene otro vector. Este vector debe ser igual al vector que se utilizo
%para crear la red. Esta comprobacion se realiza utilizando la funcion
%isequal() de la que, al correrse el script, puede verse que da 1 en
%x_comprobacion (siendo x A,B,C o D segun la imagen). Como es esperado, con
%una sola pasada ya se obtiene un estado estable (que coincide con la
%imagen enseñada) ya que los estados con los que se esta inicializando la
%red en este caso, ya son estados estables.




%Realizo 1000 simulaciones para obtener la probabilidad de caer en cada uno
%de los estados y en un estado espureo (cualquier estado estable que no sea
%enseñado a la red)
patrones_A=0;
patrones_B=0;
patrones_C=0;
patrones_D=0;
patrones_espureos=0;

for i=1:2000
    %Genero un patron aleatorio
    P_aleatorio=signo(randn(2500,1));
    fin_act=0;
    %Realizo la primer actualizacion
    actualizacion_inicial=actualizacion_sincronica(W,P_aleatorio);
    while(fin_act==0)
        actualizacion_final=actualizacion_sincronica(W,actualizacion_inicial);
        if(isequal(actualizacion_final,actualizacion_inicial))
            fin_act=1;
        else
            actualizacion_inicial=actualizacion_final;
            fin_act=0;
        end
    end
    
    if( isequal(actualizacion_final,A_vector) )
        patrones_A=patrones_A+1;    
    elseif( isequal(actualizacion_final,B_vector) )
        patrones_B=patrones_B+1;    
    elseif( isequal(actualizacion_final,C_vector) )
        patrones_C=patrones_C+1;
    elseif( isequal(actualizacion_final,D_vector) )
        patrones_D=patrones_D+1;
    else
        patrones_espureos=patrones_espureos+1;
    end    
end

probabilidadA=patrones_A/2000;
probabilidadB=patrones_B/2000;
probabilidadC=patrones_C/2000;
probabilidadD=patrones_D/2000;
probabilidadEspureo=patrones_espureos/2000;

%EXPLICACION: Para realizar esta parte del ejercico, se genera en primer
%lugar un vector aleatorio utilizando las funciones rand y signo de la
%siguiente forma P_aleatorio=signo(randn(2500,1)). Luego de generar un
%vector aleatorio, se pasa a actualizar la red con este estado inicial
%aleatorio generado y mediante un while se actualiza sincronicamente hasta
%que la red devuelve un estado igual al anterior (esto significa que la red
%llegó a un estado estable). Una vez que llega a un estado estable,
%mediante la funcion isequal() se comprueba si el estado estable coincide
%con los patrones A, B, C o D, en caso de no coincidir con ninguno, sera un
%estado espureo (ya que es un estado estable, pero no un patron enseñado).
%De la simulación utilizando 2000 patrones aleatorios se obtiene que la
%probabilidad de caer en alguno de los patrones enseñados va entre 0.06 y
%0.1 mientras que la probaiblidad de caer en un estado espureo es de 0.7
%aproximadamente. Por lo tanto se concluye que la los estados no son
%equiprobables.