clear all;
clc;
%Trabajo practico 2
%Ejercicio 1 - AND

%Defino mi w aleatoriamente, mis vectores y mi eta
w=rand(3,1);
x1=[-1;-1;1;1];
x2=[-1;1;-1;1];
yd=[-1;-1;-1;1];
n=1;

%Aprendizaje AND de 2 entradas
y=[0;0;0;0];
iteraciones=0;
while(not(isequal(y,yd)))
    iteraciones=iteraciones+1;
    %Tomo aleatoriamente una posicion del vector
    pos=randperm(length(yd));
    %Actualizo las posiciones de vector
    for i=1:length(yd)
        x=[x1(pos(i));x2(pos(i));1];
        y(pos(i))=signo((w')*x);
        dW=deltaW(n,x,y(pos(i)),yd(pos(i)));
        w=w+dW;
    end
end



clear all;
clc;
%Defino mi w aleatoriamente, mis vectores y mi eta
w=rand(5,1);
x1=[1;1;1;1;1;1;1;1;-1;-1;-1;-1;-1;-1;-1;-1];
x2=[1;1;1;1;-1;-1;-1;-1;1;1;1;1;-1;-1;-1;-1];
x3=[1;1;-1;-1;1;1;-1;-1;1;1;-1;-1;1;1;-1;-1];
x4=[1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1];
yd=[1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1;-1];
n=1;

%Aprendizaje AND de 4 entradas
y=[0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0];
iteraciones=0;
while(not(isequal(y,yd)))
    iteraciones=iteraciones+1;
    %Tomo aleatoriamente una posicion del vector
    pos=randperm(length(yd));
    %Actualizo las posiciones de vector
    for i=1:length(yd)
        x=[x1(pos(i));x2(pos(i));x3(pos(i));x4(pos(i));1];
        y(pos(i))=signo((w')*x);
        dW=deltaW(n,x,y(pos(i)),yd(pos(i)));
        w=w+dW;
    end
end