function [ vector_actualizado ] = actualizacion_asincronica(W,vector)
    
    n=length(vector);
    pos_aleatoria=randperm(n);
    for i=1:n
        vector(pos_aleatoria(i))=signo(W(pos_aleatoria(i),:)*vector);
    end
    vector_actualizado=vector;
    
end

