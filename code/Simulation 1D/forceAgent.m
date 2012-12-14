function force = forceAgent(ID,nOfAgents,AM)

%Parameters
 
global A_1 A_2 B_1 B_2 lamda epsilon r;

%       agent_i = [ID_i;x_i;v_i,v_des,t_in,t_out]
%                    1   2   3   4     5    6

% Current agent
curr_A = AM(:,ID);
Pos = curr_A(2);

des_speed = curr_A(4);

% Desired force to goal
deltat = 1;                 % Equals Timestep

desForce = des_speed/deltat;

% Repulsive force of agents

%need  a for cicle that controls every "non current" agent 
d_1_2 =@(x1,x2) abs(x2-x1)+epsilon;   % Distance between centres of masses

r_1_2 = 2*r;                          % Sum of radii
n_1_2 =@(x1,x2) (x2-x1)/d_1_2(x1,x2); % Normalized distance vector between 
                                      % agents

e_1 =@(des_speed) des_speed/abs(des_speed);      % direction of velocity
                                                 % vector of agent 1 
phiR = 0;            
phiL = 0;

Rep_force = zeros(2,1);               % Just two neighbours are possible

% Case of 2 neighbours
if(ID >= 2 && ID <= (nOfAgents-1))
    aLeftID = ID+1;
    aRightID = ID-1;
    
    aLeft = AM(:,aLeftID);
    aRight = AM(:,aRightID);
    
    xL = aLeft(2);
    xR = aRight(3);
    
    n12L = n_1_2(Pos,xL);
    n12R = n_1_2(Pos,xR);
    
    Rep_force(1) = A_1*exp((r_1_2-d_1_2(Pos,xL))/...
            (B_1))*n12L*(lamda+(1-lamda)*...
            (1+cos(phiL))/2)+A_2*exp((r_1_2-d_1_2(Pos,xL))/B_2);
    Rep_force(2) = A_1*exp((r_1_2-d_1_2(Pos,xR))/...
            (B_1))*n12R*(lamda+(1-lamda)*...
            (1+cos(phiR))/2)+A_2*exp((r_1_2-d_1_2(Pos,xR))/B_2);    
end
% First agent
if(ID == 1)
    aLeftID = ID+1;
    aLeft = AM(:,aLeftID);
    xL = aLeft(2);
    n12L = n_1_2(Pos,xL);
    Rep_force(1) = A_1*exp((r_1_2-d_1_2(Pos,xL))/...
            (B_1))*n12L*(lamda+(1-lamda)*...
            (1+cos(phiL))/2)+A_2*exp((r_1_2-d_1_2(Pos,xL))/B_2);
end
% Last agent
if(ID == nOfAgents)
    aRightID = ID-1;
    aRight = AM(:,aRightID);
    xR = aRight(2);
    n12R = n_1_2(Pos,xR);
    Rep_force(2) = A_1*exp((r_1_2-d_1_2(Pos,xR))/...
            (B_1))*n12R*(lamda+(1-lamda)*...
            (1+cos(phiR))/2)+A_2*exp((r_1_2-d_1_2(Pos,xR))/B_2);
end

Repulsion_force = Rep_force(1)-10*Rep_force(2);

force = desForce + Repulsion_force;
end
