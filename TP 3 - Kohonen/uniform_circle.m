function [ X,Y ] = uniform_distribution( r,n,x_center,y_center)
    
    radio=r*sqrt(rand(1,n));
    theeta=2*pi*(rand(1,n));
    X=radio.*cos(theeta) + x_center;
    Y=radio.*sin(theeta) + y_center;
    X=X';
    Y=Y';

end

