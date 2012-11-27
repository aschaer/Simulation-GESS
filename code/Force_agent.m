
%% Agent force Function
% Function that defines the force that will be applied on every agent


function[]=Force_agent()

%Parameters
A_1=0; %interaction strength
A_2=3; %
B_1=; %range of repulsive interaction
B_2=0.2; %
lamda=0.75; %anisotropic character of pedestrian interactions

% Desired force to goal

Desired_force(.) = agent.desiredvelocity(.)/deltat;

% Repulsive force of Boundaries

V_b(.)=;   %repulsive potential of boundaries
Boundaries_force(.) = -gradient(V_b(.));


% Repulsive force of agents
%need  a for cicle that controls every "non current" agent 

r_1_2(.)=; %Sum of radii
d_1_2(.)=; %Distance between centres of masses
n_1_2(.)=()/d_1_2; %normalized distance vector between agents
e_1(.)=; %direction of velocity vector of agent 1 
phi_1_2=arcos(-n_1_2(.)*e_1(.)); %Angle between n_1_2 and e_1

Repulsion_force(.)=A_1*exp((r_1_2(.)-d_1_2(.))/(B_1))*n_1_2(.)*...
    (lamda+(1-lamda)*(1+cos(phi_1_2(.)))/2)+A_2*exp((r_1_2(.)-d_1_2(.))/B_2);
%%
Force_agent(.)=Desired_force(.)+Boundaries_force(.)+Repulsion_force(.);
end

