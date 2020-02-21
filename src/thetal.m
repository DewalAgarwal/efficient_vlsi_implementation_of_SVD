function [ thetal ] = thetal( a, b, c, d )

thetar1 = atan((c+b)/(d-a));
thetar2 = atan((c-b)/(d+a));
thetal = (thetar1-thetar2)/2;

end

