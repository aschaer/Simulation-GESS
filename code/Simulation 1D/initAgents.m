function agentMatrix = initAgents(nOfAgents)
    % Tis function initializes the agents in an agent matrix. Each vector
    % of the matrix is an agent, which is defined as follows
    %
    %       agent_i = [ID_i;x_i;v_i,v_des,t_in,t_out, counter]
    %                    1   2   3   4     5    6        7
    agentMatrix = zeros(7,nOfAgents);
    
    % Set ID's
    for i = 1:nOfAgents
       agentMatrix(1,i) = i; 
    end
end