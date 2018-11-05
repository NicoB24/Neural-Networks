function [ dw ] = deltaW(n,x,y,yd )
    dw=n*x*(yd-y);
end

