%Nicolas Bruno - 95191
%Ejercicio 2 del parcial (Explicacion en el script)
clear all
clc

%Enseño el patron pedido y armo la matriz de Hopfield
N_neuronas=4;
N_patrones=1;
P=[1 1 1 -1]';
W=(P*P')-(N_patrones*eye(N_neuronas)); %Matriz de Hopfield

%Ahora inicializo la red en el siguiente patron
patron_inicial=[1 -1 1 1]';

%Veo que sucede con la actualizacion asincronica
test_1a=actualizacion_asincronica(W,patron_inicial);
test_2a=actualizacion_asincronica(W,test_1a);

%Utilizando como estado inicial [1 -1 1 1]', actualizando
%asincronicamente, se observa que la red evoluciona directamente en la
%primera pasada al patron  [1 1 1 -1]' o a [-1 -1 -1 1]' y se queda
%en alguno de estos con las actualizaciones sucesivas. 
%En el primer caso, es directamente el patron aprendido
%por la red. El segundo patrón en el que se puede quedar, es el negativo del
%patron aprendido, que siempre es un estado estable de las redes de
%Hopfield por la forma en la que se arma (representa un estado espureo).



%Veo que sucede con la actualizacion sincronica
test_1s=actualizacion_sincronica(W,patron_inicial);
test_2s=actualizacion_sincronica(W,test_1s);
test_3s=actualizacion_sincronica(W,test_2s);

%Utilizando como estado inicial [1 -1 1 1]', actualizando
%sincronicamente, se observa que la red evoluciona en la
%primera pasada al patron [-1 1 -1 -1]' (negativo del inicial), en la segunda vuelve a [1 -1 1 1]'
%y asi sucesivamente. Estos representan estados espureos de la red.

