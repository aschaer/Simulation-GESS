% Function for the creation of the number of agents
function [people]=Arriving_people(t)
%     % Local time step
%     deltat = 5;
% 
%     %Number of steps
%     iter = floor(length(t)/deltat);
%     
%     %Intializing solution vector
%     compact_people = zeros(iter,1);
    people = zeros(length(t),1);

    people(3) = 1;
%    people(6) = 1;
%    people(7) = 1;
    
%     % Iteration cicle (to make all the people arrive)
%     for j = 1:iter
%         % Temporary time vector   
%         t_temp = (j-1)*deltat:j*deltat-1;
%         % Filling result vector    
%         compact_people(j) = floor(sum(Prova_Gauss(t_temp)));
%     end
%     
%     % Creating time consintent people vector
%     for j = 1:iter
%         people(j*deltat) = compact_people(j);
%     end

end