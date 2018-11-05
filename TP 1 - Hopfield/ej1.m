% Ej-1
clear all;
clc;

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
testA = actualizacion_sincronica(W,A_vector);
testB = actualizacion_sincronica(W,B_vector);
testC = actualizacion_sincronica(W,C_vector);
A_resta=testA-A_vector;
B_resta=testB-B_vector;
C_resta=testC-C_vector;

%Me fijo si reconoce patrones corruptos (con vec2mat lo paso a matriz)
C_corrupto=imread('escaleram_corrupto.bmp');
C_corrupto_double=double(C_corrupto);
C_corrupto_double(C_corrupto_double==0)=-1;
C_vector_corrupto=C_corrupto_double(:);
testC_corrupto = actualizacion_sincronica(W,C_vector_corrupto);
C_resta_corrupto=testC_corrupto-C_vector;


%Entro con alguna combinación y me fijo si es un estado estable (es decir,
%sale con lo que entro)
comb_vector=A_vector+B_vector+C_vector;
test_comb = actualizacion_sincronica(W, signo(A_vector+B_vector+C_vector) );
resta_comb=comb_vector-test_comb;

