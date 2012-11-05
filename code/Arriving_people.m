%Funzione per la creazione di soggetti
function [people]=Arriving_people(t)
%Local time step
deltat=5;
%Number of steps
iter=floor(length(t)/deltat);
%Intializing solution vector
compact_people=zeros(iter);
people=zeros(length(t));
%Iteration cicle
for j=1:iter
    %Temporary time vector   
    t_temp=(j-1)*deltat:j*deltat-1;
    %Filling result vector    
    compact_people(j)=floor(sum(Prova_Gauss(t_temp)));
end
%Creating time consintent people vector
for j=1:iter
    people(j*deltat)=compact_people(j);
end

