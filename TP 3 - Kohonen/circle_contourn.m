function [ X,Y ] = circle_contourn( r,n,x_center,y_center)
    
    theeta=2*pi*(rand(1,n));
    X=r*cos(theeta) + x_center;
    Y=r*sin(theeta) + y_center;
    X=X';
    Y=Y';

end


