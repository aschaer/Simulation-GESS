function [p,ptot]=Prova_Gauss(t)
%Time intervall
deltat= t(length(t));
%Mean value
mu=1000;
%Standard deviation
sigma=1700;
%Normalisation parameter
A=2/3700;
%People function
p=t.*A.*exp(-(t-mu).^2/(2*sigma^2));
%Total people
ptot=floor(sum(p));
