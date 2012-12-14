function arrP = arrivingPeople(t)
    % This function tells us how many people are arriving at a certain time
    % t
    arrP = zeros(length(t),1);
    % Let's assume that the agents arrive in a random way. In the first
    % half of the time interval
    beta = 0.5;
    for i = 1:floor(length(t)/2)
        if(rand > 0.5)
            arrP(i) = 1;
        end
    end
end