function [ g_prima_out ] = g_prima( h,beta )
    g_prima_out=beta*(1- (tanh(beta*h)).^2);
end

