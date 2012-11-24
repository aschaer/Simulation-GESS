%% Agent force Function
% Function that defines the force that will be applied on every agent
%Parameters
A_1=;
A_2=;
B_1=;
B_2=;

function[]=Force_agent()

% Desired force to goal

% eta = 1-(average_0velocity())/(v_0(0))
% v_0 = (1-eta)*v_0(0)+eta*v_max;
Desired_force(agent.velocity) = 1/deltat*(v_desired()-agent.velocity);

% Repulsive force of Boundaries

V_b=;   %repulsive potential
Boundaries_force() = -gradient(V_b());


% Repulsive force of agents
%
r_1_2=;
d_1_2=;
phi_1_2=;
Repulsion_force()=A_1*exp((r_1_2()-d_1_2())/B_1)*n_1_2()*...
    (lamda+(1-lamda)*(1+cos(phi_1_2()))/2)+A_2*exp((r_1_2()-d_1_2())/B_2);
%%

Force_agent()=Desired_force()+Boundaries_force()+Repulsion_force();

end

