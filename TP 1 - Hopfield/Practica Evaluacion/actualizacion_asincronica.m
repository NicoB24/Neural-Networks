function [ vector_actualizado, energia ] = actualizacion_asincronica(W,vector)
    
    n=length(vector);
    pos_aleatoria=randperm(n);
    energia=[];
    %Calculo la energia inicial
    energia_actual=energia_hopfield(W,vector);
    energia=[energia ; energia_actual];
    %En cada iteracion actualizo y calculo la energia
    for i=1:n
        vector(pos_aleatoria(i))=signo(W(pos_aleatoria(i),:)*vector);
        energia_actual=energia_hopfield(W,vector);
        energia=[energia ; energia_actual];
    end
    vector_actualizado=vector;
    
end

