%% 1D Mensa Simulation

clear all, close all, clc;

% Due to computation cost we decided to simplify our complete 2D model of
% the mensa to a column analysis. This shouldn't be such a big deal in our
% case, since we are interested in optimizing the efficiency of the mensa.
% Therefore we are interested in the behaviour of a column for changing
% parameters.

%% Load Parameters
Parameters;

%WARNING CHOOSE RIGHT FILE!!!
fprintf('Parameters loaded\n')

%% Set desired velocity "field"

desVel = desiredVelocity(dimension,efficiency);
                            
           
%% Initialize agents:

%       AM(:,i) = agent_i = [ID_i;x_i;v_i,v_des,t_in,t_out,counter]
%                              1   2   3   4     5    6       7  
AM = initAgents(totP);

%% Initialize log matrix

logMatrix = cell(iter,1);          % This is were all the data will be kept

fprintf('Ready for simulation.\n')
                            
%% Time iteration

fprintf('\nSimulation started. Please wait...\n\n')
% Simulation Time
simTime = tic;

% Set initial agent with initial velocity
AM(2,1) = 2;            % Initial position of first agent
AM(3,1) = 3;            % Initial velocity of first agent
AM(4,1) = desVel(2); 
AM(5,1) = 0;            % Entering Time
logMatrix{1} = AM;

for i = 2:iter
    % Load Previous state
    AM = logMatrix{i-1};
    
    % Incoming people at t = i:
    newPeople = arrP(i);
    
    arrivedP = sum(arrP(1:i-1));
    
    if(newPeople ~= 0)
       % If someone arrives put him in the playboard
       for k = arrivedP+1:arrivedP + newPeople;
          updatingAgent = AM(:,k);
          updatingAgent(2) = 1;             % Set position
          updatingAgent(3) = 2;             % Set initial velocity
          updatingAgent(4) = desVel(1);     % Set desired velocity
          updatingAgent(5) = i;             % Start stopwatch
          AM(:,k) = updatingAgent;          % Rewrite agent in AM
          clear updatingAgent;
       end
    end
    
    % Update positions of the relevant agents
    logMatrix{i} = updateAgents(totP,AM,i,desVel);
   
    % logMatrix{i} = AM;
end
toc(simTime);

fprintf('Simulation done.\n')

%% Statistics of the Simulation

% In all the simulations we've done, the last exiting agent was fouling the
% results! So we neglect him
temp = walkingTime;
clear walkingTime;
walkingTime = temp(1:(totP-1));

% Find exiting time of the last-1 exiting agent
exitingTimesMatrix = zeros(totP-1,iter);
for i = 1:totP-1
    for k = 1:iter
        exitingTimesMatrix(i,k) = logMatrix{k}(6,i);
    end
end

exitingTimes = zeros(totP-1,1);
for k = 1:totP-1
    exitingTimes(k) = max(exitingTimesMatrix(k,:));
end

% Last exiting person exits at maximum value of exiting time vector
lastExitTime = max(exitingTimes);

% Prepare plots display
xplots = 3; yplots = 2;
scrsz = get(0,'ScreenSize');
k = 0;
positions = zeros(xplots*yplots,4);
for xp = 1:xplots
    for yp = 1:yplots
        k = k+1;
        positions(k,:) = [(xp-1)*scrsz(3)/xplots (yplots-yp)*...
            scrsz(4)/yplots scrsz(3)/xplots scrsz(4)/yplots]+1;
    end
end

% Extreme values:
[maxWT,agentMax] = max(abs(walkingTime));
[minWT,agentMin] = min(abs(walkingTime));

fignum = 2;
histWT = figure(fignum);
hist(walkingTime,50)
title(['Walking Time Distribution. Tot # of Agents ',num2str(totP)],...
    'fontsize',14)
xlabel('Walkthrough-Time [s]','fontsize',14)
ylabel('# of Agents [-]','fontsize',14)
set(gcf,'OuterPosition',positions(fignum,:))

% Count how many have not arrived. Set teir WT to timeinterval
notArrived = 0;
for i = 1:totP-1
   if(walkingTime(i) == 0)
       walkingTime(i) = iter;
       notArrived = notArrived + 1;
   end       
end


% Mean walkthrough time:
meanWT = mean(walkingTime);

% Standard Deviation of Walkstroughtime
stdWT = std(walkingTime);

%Plot positions in time of a all agents
posMatrix = zeros(iter,totP-1);

for i = 1:iter
   for k = 1:totP-1
        posMatrix(i,k)=logMatrix{i}(2,k);
    end
end

% Normalize position matrix with respect to goal
posMatrix = posMatrix/goal;

fignum = 3;
posInTimeAll = figure(fignum);
hold on
for i=1:totP-1
    col = [0.3 0.5 i/totP];
    plot(posMatrix(:,i),'Color',col)
    xlim([0 lastExitTime*1.01])
    ylim([0 1.05])

end
title('Relative Position of All Agents as Function of Time','fontsize',14)
xlabel('Time t [s]','fontsize',14)
ylabel('Reative Position x/goal [-]','fontsize',14)
hold off
set(gcf,'OuterPosition',positions(fignum,:))

%Plot positions in time of a part agents (frac-th part)
frac = 10;
posMatrixFrac = zeros(iter,floor((totP-1)/frac));

for i = 1:iter
   for k = 1:floor((totP-1)/frac)
        posMatrixFrac(i,k)=logMatrix{i}(2,k*frac);
    end
end
% Normalize position matrix with respect to goal
posMatrixFrac = posMatrixFrac/goal;

fignum = 4;
posInTimeFrac = figure(fignum);
hold on
for i=1:floor((totP-1)/frac)
    col = [0.3 0.5 i/totP];
    plot(posMatrixFrac(:,i),'Color',col)
    xlim([0 lastExitTime*1.01])
    ylim([0 1.05])
end
title('Relative Position of Half the Agents as Function of Time',...
    'fontsize',14)
xlabel('Time t [s]','fontsize',14)
ylabel('Reative Position x/goal [-]','fontsize',14)
hold off
set(gcf,'OuterPosition',positions(fignum,:))

% Plot the normalized walking time
maxWT = max(abs(walkingTime));
minWT = min(walkingTime);
normWalkingTime = walkingTime/maxWT;

agents = zeros(totP-1,1);
for i = 1:totP-1
    agents(i) = i;
end

fignum = 5;
normWTplot = figure(fignum);
plot(agents,normWalkingTime,'*r')
xlim([-1 length(agents)+1])
ylim([0 1.01])
title('Normalized Walking Time of each Agent','fontsize',14)
xlabel('Agent ID [-]','fontsize',14)
ylabel('Normalized Walkthrough-Time t_{WT}/max(t_{WT}) [-]','fontsize',14)
set(gcf,'OuterPosition',positions(fignum,:))

% OUTPUT: Data of the simulation
fprintf('\nDATA OF THE SIMULATION\n######################\n\n')
fprintf(['Total number of agents of the simulation: ',num2str(totP),'\n']);
fprintf(['"Stop-time": ',num2str(maxStop),'s\n'])
fprintf(['# of not arrived agents: ',num2str(notArrived),'\n'])
fprintf(['Mean walkthrough-time: ',num2str(meanWT),'s\n'])
fprintf(['The slowest agent is Agent #',num2str(agentMax),...
    '\n\tHe needs ',num2str(maxWT),'s to go through the mensa\n'])
fprintf(['The fastest agent is Agent #',num2str(agentMin),...
    '\n\tHe needs ',num2str(minWT),'s to go through the mensa\n'])
fprintf(['The Standard Deviation of the walkthrough time is\n\tstdWT = ',...
    num2str(stdWT),'s\n'])
fprintf(['Last Agent Exits at t = ',num2str(lastExitTime),'s\n\n'])


%% Save results

fprintf('Saving the results...\n')
saveas(histWT,'WalkingTimeHist.eps','psc2')
saveas(posInTimeAll,'PositionAllAgents.eps','psc2')
saveas(posInTimeFrac,'PositionFracAgents.eps','psc2')
saveas(normWTplot,'NormalizedWalkingTimePlot.eps','psc2')
save('SimResults.mat','logMatrix','walkingTime','totP',...
    'notArrived','meanWT','maxWT','minWT','stdWT','lastExitTime')
fprintf('Results saved.\n\n')

%% Video of the simulation

if(videoOn)
    fignum = 6;
    vidFig = figure(fignum);
    set(gcf,'OuterPosition',positions(fignum,:))
    fprintf('Preparing for video...\n')
    vidObj = VideoWriter('OneDMensaSim.avi');
    vidObj.FrameRate = 15;
    open(vidObj);
    
    [M,N] = size(posMatrixFrac);
    agentColor = [0 .7 .7];
    %         1     2    3     4     5        6
    vert = [0 .02;0 .1;1 0.02;1 .1;1.1 0.02;1.1 .1;...
        0 -.02;0 -.1;1 -.02;1 -.1;1.1 -.02;1.1 -.1];
    %     7       8      9    10     11      12  
    faces =[1 5 6 2;7 11 12 8;4 6 12 10];
    
    patchinfo.Vertices = vert;
    patchinfo.Faces = faces;
    patchinfo.FaceColor = [.5 .5 .5];
    
    fprintf('Creating animation. Please Wait...\n')
    % Time iteration
    for i = 1:M;
        % Agent iteration:
        plot([0 1.1],[0 0],'LineWidth',10,'Color',[0 0 0])
        hold on;
        patch(patchinfo)
        for k = 1:N;
            if(posMatrixFrac(i,k) > 0 && posMatrixFrac(i,k) < 1)
                plot(posMatrixFrac(i,k),0,'.','Color',agentColor) 
            end
        end
        xlim([0,1.1])
        ylim([-.1 .1])
        hold off
        title('OneDimensional video','fontsize',14)
        
        F = getframe;
        writeVideo(vidObj,F);
    end
    close(vidObj)
    fprintf('Video has been created.\n\n')
end   
%% Saving video Frame

if(true)
    fignum = 1;
    frameFig = figure(fignum);
    set(gcf,'OuterPosition',positions(fignum,:))
    fprintf('Saving one frame\n')
    plot([0 1.1],[0 0],'LineWidth',10,'Color',[0 0 0])
    hold on;
    patch(patchinfo)
    for k = 1:N;
        if(posMatrixFrac(floor(M/2),k) > 0 && ...
                posMatrixFrac(floor(M/2),k) < 1)
            plot(posMatrixFrac(floor(M/2),k),0,'.','Color',agentColor) 
        end
    end
    xlim([0,1.1])
    ylim([-.1 .1])
    hold off
    title('OneDimensional video','fontsize',14)
    
    saveas(frameFig,'oneDVideoFrame.eps','psc2')
    fprintf('Frame saved.\n\n')
end
    
    


































                            
                            
                            
               