%%Updating agents function
 %Function that updates the propreties of the agents
 
    function[]=Update_agents()
    %% Dichiarazione variabili
    % DESCRIPTIVE TEXT
    Velocity_agent(_(t+deltat))=Velocity_agent(t)+Force_agent(t)*deltat;
    Position_agent(_(t+deltat))=Position_agent(t)+Velocity_agent(t)*deltat+1/2*Force_agent(t)*deltat^2

    %% Ciclo Agenti
    % Ciclo che controlla tutti gli agenti
    for j=1:length(agents)

        if (agent.ID==j)
            agent=currentagent; %make the j-te agent as current agent
            currentagent.position(t+deltat)=;
            currentagent.velocity(t+deltat)=;
            currentagent.desired_velocity(currentagent.position(t+deltat))=;
        end

    end
    %%
%%