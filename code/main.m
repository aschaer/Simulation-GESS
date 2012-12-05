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
t = 0:2.5*500;             % -> We simulate 2.5 hours. Simulation step: 1s
t_F = t(length(t));         % Final Time of Simulation

% Potential boundary
global V_b;
V_b = getMensa();

% Define treshold y value for goal (read plausible value from the map)
y_goal = 700;

% Desired velocity matrix
global desVel_x;
global desVel_y;
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
   
   % Print how far we are with the simulation.
   % Just add a % at the beginning if you don't want to see this.
   if mod( i+1, t_F/10 ) == 0
        fprintf('%.f%%  ',100*((i+1)./t_F));
   end
end

% Save the results in a separate file
save('simulationResults.mat','log_Matrix','walking_time');

fprintf('\n\n########################## \nSimulation done and saved. \n');
fprintf('#########YEAH!############ \n########################## \n\n');


%% Create Video of Simulation

createVideo = true;
if createVideo
    fprintf('Creating video of the simulation. Please Wait... \n');
    % Prepare objects
    fig = figure;
    set(gca,'Visible','off');
%    set(fig,'Position',[400 380 560 420]);
    movie = VideoWriter('MensaSimVideo.avi');
    open(movie);
    [width, height] = meshgrid(1:1000,1:1000);
    colormap([1 1 1; .5 .5 .5; 0 0 0]);

    % Create Movie
    for time = 1:t_F+1
        mesh(width, height, V_b);
        view([0 0 1]);
%        hold on;
        % Current agent Matrix
        AM = log_Matrix{time};
  
        for pers = 1:tot_people;
            % Plot position of each agent
            current_agent = AM(:,pers);
        
%            if (current_agent(1) ~=0 || current_agent(2) > 0)
            if current_agent(2) > 0
                    plot(current_agent(2),current_agent(3),'o','LineWidth',5,...
                    'Color',[0 0.7 0.7]);
            end
        end
%        hold off;
        writeVideo(movie,getframe(gca));
        
        % Print how far we are with the video.
        % Just add a % at the beginning if you don't want to see this.
        fprintf('Did frame no. %.f\t of %.f frames. \n',time,t_F);
        
%        if mod( time, (t_F+1)/100 ) == 0
%            fprintf('%.f%%  ',1000*(time./(t_F+1)));
%        end
    end

    close(gcf);

    fprintf('Video has been created. Everything saved. \n');
else
    fprintf('No video requested. \n');
end






