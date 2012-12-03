%Agent force Function
% Function that defines the force that will be applied on every agent
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
        
function [force_x,force_y] = Force_agent(ID,nOfAgents,V_b,AM)

%Parameters
A_1 = 0;            % interaction strength
A_2 = 3; 
B_1 = 1;            % range of repulsive interaction
B_2 = 0.2;          %
lamda = 0.75;       % anisotropic character of pedestrian interactions

% Current agent
curr_A = AM(:,ID);
Pos_x = curr_A(2);
Pos_y = curr_A(3);
des_speed = [curr_A(8); curr_A(9)];

% Desired force to goal
deltat = 1;     % Equals Timestep

Desired_force_x = curr_A(8)/deltat;
Desired_force_y = curr_A(9)/deltat;

% Repulsive force of Boundaries
[boundF_x,boundF_y] = -gradient(V_b);

% Repulsive force of agents

%need  a for cicle that controls every "non current" agent 
d_1_2 =@(x1,y1,x2,y2) sqrt((x2-x1)^2+(y2-y1)^2); % Distance between centres 
                                                 % of masses
r_1_2 = 2*r;                                     % Sum of radii
n_1_2_x =@(x1,x2)(x2-x1)/d_1_2;                  % Normalized distance 
                                                 % vector between agents
n_1_2_y =@(y1,y2)(y2-y1)/d_1_2;
n_1_2 = ones(1,2);                               % We need the vector to do
                                                 % a scalar product
n_1_2(:,1) = n_1_2_x;
n_1_2(:,2) = n_1_2_y;
e_1 =@(des_speed) des_speed/abs(des_speed);      % direction of velocity
                                                 % vector of agent 1 
phi_1_2 =@(n_1_2,e_1) arcos(dot(-n_1_2,e_1));    % Angle between n_1_2 
                                                 % and e_1

Rep_force_x = zeros(nOfAgents-1,1);
Rep_force_y = zeros(nOfAgents-1,1);


for k = 1:nOfAgents
    if k~=ID
        % Helping Variable
        agent_k = AM(:,k);
        % Position of current agent is argument of function
        % Position of k'th agent
        x_k = agent_k(2);
        y_k =agent_k(3);
        
        n_1_2 = [Pos_x-x_k; Pos_y-y_k]/d_1_2(Pos_x,Pos_y,x_k,y_k);
        
        
        Rep_force_x(k) = A_1*exp((r_1_2-d_1_2(Pos_x,Pos_y,x_k,y_k))/...
            (B_1))*n_1_2_x(Pos_x,x_k)*(lamda+(1-lamda)*...
            (1+cos(phi_1_2(n_1_2,e_1)))/2)+...
            A_2*exp((r_1_2-d_1_2(Pos_x,Pos_y,x_k,y_k))/B_2);
        Rep_force_y(k) = A_1*exp((r_1_2-d_1_2(Pos_x,Pos_y,x_k,y_k))/...
            (B_1))*n_1_2_y(Pos_y,y_k)*(lamda+(1-lamda)...
            *(1+cos(phi_1_2(n_1_2,e_1)))/2)+...
            A_2*exp((r_1_2-d_1_2(Pos_x,Pos_y,x_k,y_k))/B_2);
        
        clear x_k y_k;
    end
end
Repulsion_force_x = sum(Rep_force_x);
Repulsion_force_y = sum(Rep_force_y);

force_x = Desired_force_x + boundF_x + Repulsion_force_x;
force_y = Desired_force_y + boundF_y + Repulsion_force_y;


end

