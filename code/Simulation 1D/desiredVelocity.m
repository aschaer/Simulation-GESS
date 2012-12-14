function desVel = desiredVelocity(dimension,efficiency)
    % Make global variables available
    global lengthOfFood startPointFood;
    desVel = .1*ones(length(dimension),1);
    
    % Select case
    if(efficiency == 1)
        desVel(startPointFood:startPointFood+lengthOfFood) = -1e12;
    elseif(efficiency == 2)
        desVel(startPointFood:startPointFood+lengthOfFood) = .5;
    end

end