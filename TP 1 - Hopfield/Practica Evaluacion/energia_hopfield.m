function [ E ] = energia_hopfield(w,s)
    E=0;
    for i=1:length(w)
        for j=1:length(w)
            E=E+w(i,j)*s(i)*s(j);
        end
    end
    E=(-1/2)*E;
end

