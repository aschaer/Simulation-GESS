% Agent initializing function
function agent_Matrix = init_agents(tot_people)
    % Initialize Matrix as a empty array of structs
    agent_Matrix = zeros(9,tot_people);
    
    % ELEMENTS OF agent_Matrix ARE VECTORS CONTAINING THE INFORMATION OF
    % THE AGENT i
    %
    %   agent_Matrix(:,i) = [ID(i) 
    %                      Pos_x(i)
    %                      Pos_y(i)
    %                      v_x(i)
    %                      v_y(i)
    %                      ent_t(i)
    %                      ext_t(i)
    %                      des_v_x(i)
    %                      des_v_y(i)]
 
    % Fill the agent_Matrix with ordered agents, i.e. set the ID's
    for i = 1:tot_people;
        agent_Matrix(1,i) = i; 
    end

end