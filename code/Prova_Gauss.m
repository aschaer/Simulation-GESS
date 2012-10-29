clc
clear all
close all
t=0:2.5*3600;
deltat= t(length(t));
%mu=deltat/2;
mu=1000;
sigma=1700;
A=2/3700;
%p=A*(normpdf(t,mu,sigma)+1);
p=t.*A.*exp(-(t-mu).^2/(2*sigma^2));
ptot=floor(sum(p));
ptot
figure 
plot(t,p)
