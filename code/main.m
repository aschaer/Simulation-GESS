%% Mensa Simulation

% Group Name:     Hungry People
% Group Members:  Flurin Arner
%                 Samuele Demicheli
%                 Alessandro Schaer
%                 Gerson Solca'
%                 
% This file executes the simulation calling all the other implemented 
% functions

clear all; close all; clc;

%% Parameters

% Define the time interval in which we want to simulate
t = 0:2.5*3600;             % -> We simulate 2.5 hours. Simulation step: 1s
t_F = t(length(t));         % Final Time of Simulation

% Potential boundary
global V_b;
V_b = getMensa();

% Define treshold y value for goal (read plausible value from the map)
y_goal = 700;

% Desired velocity matrix
global desVel_x;
global desVel_y;
desVel_x = zeros(size(V_b));
desVel_y = ones(size(V_b));

disp('Computing total amount of agents...')

% Vector contianing the arriving people as a gaussian distr. over time
incoming_people = Arriving_people(t);

% Total people coming during the whole time interval:
tot_people = sum(incoming_people);
disp(' ')
disp('Total amount of agents is:')
tot_people
disp('over a time interval of ')
t_F
disp('seconds.')
disp(' ')

% Define variable which we're interested in
global walking_time;
walking_time = zeros(tot_people,1);

%% Agent Initialization
disp('Initializing agents...')
% Initialize the agent Matrix AM:
AM = init_agents(tot_people);
% ELEMENTS OF agent_Matrix ARE VECTORS CONTAINING THE INFORMATION OF
% THE AGENT i
%
%   agent_Matrix(:,i) = [i 
%                      Pos_xi
%                      Pos_yi
%                      v_xi
%                      v_yi
%                      ent_ti
%                      ext_ti
%                      des_v_xi
%                      des_v_yi]
disp('Initialization done.')
disp(' ')

%% Actual Simulation
disp('#################')
disp('Begin Simulation.')
disp('#################')
disp(' ')
disp('Computing time iterations. Please be patient: the procedure')
disp('may take some minutes...')
disp(' ')

% Initialize log matrix: each time step status gets saved here
log_Matrix = cell(t_F+1,1);

% Log the arrived people
arrived_people = 0;

for i = 0:t_F-1;
   % Update log:
   arrived_people = sum(incoming_people(i+1));
   arrived_people_new = arrived_people + incoming_people(i+2);
   
   % Make appear agents as suggested by incoming_people
   % RELEVANT AGENTS HAVE A x-POSITION UNEQUAL 0!
   if(arrived_people_new ~= arrived_people)
       % Set initial positions of new agents to valid position
       for l = arrived_people+1:arrived_people_new+1
            updatingAgent = AM(:,l);
            % Initialize x-Position as 498,599,500 or 501 (in the middle of
            % the mensa map along the x-Axis) 
            updatingAgent(2) = 498+l-arrived_people;
            
            % y-Position can stay at 0
            
            % delete helping variable to be sure to not mess up anithing
            clear updatingAgent;     
       end
   end
   
   % Compute and store timestep of relevant agents (Update_agents already
   % knows which agents are relevant)
   log_Matrix{i+1} = Update_agents(tot_people,AM,i,y_goal); 
   % {i+1} because the matrix indeces begin at 1 and not at 0 and i begins
   % at 0
end

% Save the results in a separate file
save('simulationResults.mat','log_Matrix','walking_time');

disp('##########################')
disp('Simulation done and saved.')
disp('#########YEAH!############')
disp('##########################')
disp(' ')

%% Create Video of Simulation

createVideo = true;
if(createVideo)
    disp('Creating video of the simulation. Please Wait...')
    % Prepare objects
    fig = figure;
    movie = VideoWriter('MensaSimVideo.avi');
    open(movie);

    for time = 1:10:t_F+1
        image(V_b);
        colormap([1 1 1; .5 .5 .5; 0 0 0]);
        hold on;
        % Current agent Matrix
        AM = log_Matrix{time};
  
        for pers = 1:tot_people;
            % Plot position of each agent
            current_agent = AM(:,pers);
        
            if (current_agent(1) ~=0 || current_agent(2) > 0)
                plot(current_agent(2),current_agent(3),'o','LineWidth',5,...
                    'Color',[0 0.7 0.7]);
            end
        end
        hold off;
        F = getframe(fig);
        writeVideo(movie,F);
    end

    close(fig);
    close(movie);

    disp('Video has been created. Everything saved.')
else
    disp('No video requested.')
    disp(' ')
end


















