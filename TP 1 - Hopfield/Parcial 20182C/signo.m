function [ data_sign ] = signo( data )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    data_sign=sign(data);
    data_sign(data_sign==0)=1;
end

