function [ A ] = CORDIC( A, theta )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

c_angle=[];
for i=1:100
    if(theta<0.01)
        break;
    end
    
    if(theta<atan(2^(-(i-1))))
        c_angle=[c_angle 0];
    
    else
        c_angle=[c_angle 1];
    end
    theta=theta-atand(2^(-(i-1)));
end

for i=1:length(c_angle)
    A=A*[1 c_angle(i)*2^(-(i-1));-c_angle(i)*2^(-(i-1)) 1];
    A=cos(c_angle(i)*atan(2^(-(i-1))))*A;
end
