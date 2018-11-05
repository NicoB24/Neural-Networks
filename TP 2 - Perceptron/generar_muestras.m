function [ entradas,salidas ] = generar_muestras( separacion )
    x = linspace(0, 2*pi, separacion);
    y = linspace(0, 2*pi, separacion);
    z = linspace(-1, 1, separacion);
    entradas = combvec(x, y, z)';
    
    salidas = zeros(size(entradas,1), 1);

    for i = 1:size(entradas, 1)
        entrada = entradas(i, :);
        x = entrada(1);
        y = entrada(2);
        z = entrada(3);
        salidas(i) = (sin(x) + cos(y) + z);        
    end
    
end

