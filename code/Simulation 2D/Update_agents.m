%%Updating agents function
 %Function that updates the propreties of the agents
 
 function updatedAM = Update_agents(nOfPeople,agent_Matrix,time,y_goal)

% Make walking time available
global walking_time;
% Make potential available
global desVel_x;
global desVel_y;

% Iterate over all present agents:
    for i = 1:nOfPeople
        % Select Agent (easier to work -> just 1 index necessary)
        updatingAgent = agent_Matrix(:,i);
        %       With        
        %       agent_Matrix(:,i) = [i              (1)
        %                          Pos_xi           (2)
        %                          Pos_yi           (3)
        %                          v_xi             (4)
        %                          v_yi             (5)
        %                          ent_ti           (6)
        %                          ext_ti           (7)
        %                          des_v_xi         (8)
        %                          des_v_yi]        (9)

        % Verify if agent is in the mensa and has still to be considered,
        % i.e. ID different from 0
        if(updatingAgent(1) ~= 0 && (updatingAgent(2) > 0 && ...
                (updatingAgent(3) >= 0 && updatingAgent(3) < y_goal)))
           % If it is, then compute new position
           % NOTE: dt = 1!
           
                % -> compute force on agent => get acceleration
                [force_x,force_y] = Force_agent(updatingAgent(1),...
                    nOfPeople,agent_Matrix);
				% Mass of agents (ponderates the force on the agents)
				m = 100;
                % -> compute new speed of agent
                updatingAgent(4) = updatingAgent(4) + force_x/m;
                updatingAgent(5) = updatingAgent(5) + force_y/m;
                
                % -> compute new position
                updatingAgent(2) = updatingAgent(2) + updatingAgent(4) +...
                    0.5*force_x/m;
                updatingAgent(3) = updatingAgent(3) + updatingAgent(5) +...
                    0.5*force_y/m;
                
%                 % Update Desired Velocity
%             updatingAgent(8) = desVel_x(ceil(updatingAgent(2)),...
%                 ceil(updatingAgent(3)));
%             updatingAgent(9) = desVel_y(ceil(updatingAgent(2)),...
%                 ceil(updatingAgent(3)));
                     
           % If after step, goal reached: Save walking time.
           if(updatingAgent(3) == y_goal)
               updatingAgent(7) = time;
               walking_time(i) = updatingAgent(7)-updatingAgent(6);
               % Make disappear agent -> ID = 0
               updatingAgent(1) = 0;
           end   
        end
        agent_Matrix(:,i) = updatingAgent;
        clear updatingAgent;
        
    end
    % Store Updated Agent Matrix (AM)
    updatedAM = agent_Matrix;
end
