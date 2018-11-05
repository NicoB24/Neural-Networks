function [ Energia ] = calcular_energia( P )

%Le concateno ceros alrededor a la matriz para simplificar
aux=zeros(1, length(P(:,1)));
M=vertcat([P aux']);
M=vertcat([aux' M]);
aux=zeros(1, length(P(1,:))+2);
M=horzcat([M;aux]);
M=horzcat([aux;M]);

%Calculo la energia
E=0;
for fila=2:length(M(:,1))-1
    for columna=2:length(M(1,:))-1        
        E=E + M(fila,columna)*(M(fila+1,columna)+M(fila-1,columna)+M(fila,columna+1)+M(fila,columna-1));          
    end
end
        
Energia=(1/2)*E; 

end

