function [desVel_x, desVel_y] = getVectors(MensaSize)

%%%% Still very rudimental for the moment,
%%%% but it's so we can continue with the Video
%%%% of the simulation and programming in general.

maxForce = 10;
% temp = zeros(MensaSize, MensaSize);

% Forces on agents in direction x 
desVel_x = zeros(MensaSize);

for i = 1:MensaSize/2
    for j = 1:MensaSize/8
        % Move Agents from the left to the center of the Mensa
        desVel_x(MensaSize/2 + i,MensaSize*0/8 + j) = floor(maxForce);
        desVel_x(MensaSize/2 + i,MensaSize*1/8 + j) = floor(maxForce/2);
        desVel_x(MensaSize/2 + i,MensaSize*2/8 + j) = floor(maxForce/3);
        desVel_x(MensaSize/2 + i,MensaSize*3/8 + j) = floor(maxForce/4);
        
        % The same for the right part of the Mensa
%        desVel_x(:,MensaSize/2 + i) =                 
%        desVel_x(:,MensaSize/2 + j) = desVel_x(:,j);
        desVel_x(MensaSize/2 + i,MensaSize*4/8 + j) = floor(maxForce/4);
        desVel_x(MensaSize/2 + i,MensaSize*5/8 + j) = floor(maxForce/3);
        desVel_x(MensaSize/2 + i,MensaSize*6/8 + j) = floor(maxForce/2);
        desVel_x(MensaSize/2 + i,MensaSize*7/8 + j) = floor(maxForce);

        % After agents pay, they may move again towards the sides
%        desVel_x(i,j) = - desVel_x(MensaSize-i,j);
        desVel_x(i,MensaSize*0/8 + j) = -floor(maxForce/4);
        desVel_x(i,MensaSize*1/8 + j) = -floor(maxForce/3);
        desVel_x(i,MensaSize*2/8 + j) = -floor(maxForce/2);
        desVel_x(i,MensaSize*3/8 + j) = -floor(maxForce);
        desVel_x(i,MensaSize*4/8 + j) = -floor(maxForce);
        desVel_x(i,MensaSize*5/8 + j) = -floor(maxForce/2);
        desVel_x(i,MensaSize*6/8 + j) = -floor(maxForce/3);
        desVel_x(i,MensaSize*7/8 + j) = -floor(maxForce/4);
        

    end
end


% Forces on agents in direction y
desVel_y = ones(MensaSize);

end