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

% Images desired?
visual = false;

%% Parameters

% Define the time interval in which we want to simulate
t = 0:600;             % -> We simulate 2.5 hours. Simulation step: 1s
t_F = t(length(t));         % Final Time of Simulation

% Potential boundary
global V_b;
V_b = getMensa(visual);

% Define treshold y value for goal (read plausible value from the map)
y_goal = 700;

% Desired velocity matrix
global desVel_x;
global desVel_y;
% desVel_x = zeros(size(V_b));
% desVel_y = 100*ones(size(V_b));

% disp('Computing total amount of agents...')

MensaSize = size(V_b);

fprintf('Getting Vectors...\n')
[desVel_x, desVel_y] = getVectors(MensaSize);

fprintf('Computing total amount of agents...\n\n');

% Vector contianing the arriving people as a gaussian distr. over time
incoming_people = Arriving_people(t);

% Total people coming during the whole time interval:
tot_people = sum(incoming_people);
fprintf('Total amount of agents is: %.f\n',tot_people);

fprintf('Over a time interval of %.f seconds.\n\n',t_F);

% Define variable which we're interested in
global walking_time;
walking_time = zeros(tot_people,1);

%% Agent Initialization
fprintf('Initializing agents...\n\n');
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
fprintf('Initialization done.\n\n')

%% Actual Simulation
fprintf('################# \nStarting Simulation. \n');
fprintf('################# \n\n');
fprintf('Computing time iterations. Please be patient: ');
fprintf('the procedure \nmay take a few minutes...\n\n');

% Initialize log matrix: each time step status gets saved here
log_Matrix = cell(t_F,1);

% Log the arrived people
placed_people = 0;

for i = 1:t_F-1;
    % Update log
    placed_people = sum(incoming_people(1:i));
    new_people = incoming_people(i+1);
    new_and_placed_people = placed_people + new_people;
    
    % Create helping vector to place agents
    placingAgent = zeros(9,1);
   
    % Make appear agents as suggested by incoming_people

    % Set initial positions of new agents to valid position
    for k = placed_people:new_and_placed_people;
        % Already placed agents have an x-position different from 0!
        if  k ~= 0 && AM(2,k) == 0
            placingAgent = AM(:,k);
            % Initialize x-Position as 496, 497, ..., 505 (in the middle of
            % the mensa map along the y=10-Axis)
            placingAgent(2) = 498 + floor( 9*rand(1) );
            
            % y-Position to 10
            placingAgent(3) = 10;
            
            % Set des velocity
            placingAgent(8) = desVel_x(placingAgent(2),placingAgent(3));
            placingAgent(9) = desVel_y(placingAgent(2),placingAgent(3));
            
            % Rewrite AM(:,k)
            AM(:,k) = placingAgent;
        end
    end
   
    % Compute and store timestep of relevant agents (Update_agents already
    % knows which agents are relevant)
    AM = Update_agents(new_and_placed_people,AM,i,y_goal); 
%    log_Matrix{i} = AM;
    % {i+1} because the matrix indeces begin at 1 and not at 0 and i begins
    % at 0
   
    % Print how far we are with the simulation.
    % Just add a % at the beginning if you don't want to see this.
    if mod( i+1, t_F/10 ) == 0
         fprintf('%.f%% ',100*((i+1)./t_F));
    end
end

% Save the results in a separate file
save('simulationResults.mat','log_Matrix','walking_time');

fprintf('\n\n########################## \nSimulation done and saved. \n');
fprintf('#########YEAH!############ \n########################## \n\n');


%% Create Video of Simulation

if visual
    close all;
    fprintf('Creating video of the simulation. Please Wait... \n');
    % Prepare objects
    fig = figure;
    vidObj = VideoWriter('MensaSimVideo.avi');
    open(vidObj);

    [width, height] = meshgrid(1:1000,1:1000);
    
    for time = 1:t_F
        mesh(width,height,V_b);
        colormap([1 1 1; .5 .5 .5; 0 0 0]);
        view([0 0 1]);
        hold on;
        % Current agent Matrix
        AM = log_Matrix{time};
  
        for pers = 1:tot_people;
            % Plot position of each agent
            current_agent = AM(:,pers);
        
            if (current_agent(1) ~=0 || current_agent(3) > 5)
                plot3(current_agent(2),current_agent(3),0,'o',...
                    'LineWidth',10,'Color',[0 0.7 0.7]);
            end
        end
        hold off;
        F = getframe(fig);
        writeVideo(vidObj,F);
        
        % Print how far we are with the video.
        % Just add a % at the beginning if you don't want to see this.
        fprintf('Did frame no. %.f\t of %.f frames. \n',time,t_F);
        
% if mod( time, (t_F+1)/100 ) == 0
% fprintf('%.f%% ',1000*(time./(t_F+1)));
% end
        
    end

    close(vidObj);
    close(fig);

    fprintf('Video has been created. Everything saved. \n');
else
    fprintf('No video requested. \n');
end


















