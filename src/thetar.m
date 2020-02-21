function [ thetar ] = thetar( a, b, c, d )

thetar1=atan((c+b)/(d-a));
thetar2=atan((c-b)/(d+a));
thetar=(thetar1+thetar2)/2;

end

