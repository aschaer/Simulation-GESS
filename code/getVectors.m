function [desVel_x, desVel_y] = getVectors(MensaSize)


desVel_x = zeros(MensaSize);

maxForce = 5;

for i = 1:MensaSize/2
    for j = 1:MensaSize/2
        desVel_x(MensaSize/2 + i,j) = maxForce;
        
%        desVel_x(i,j) = - desVel_x(MensaSize-i,j);
        
%        desVel_x(:,MensaSize/2 + j) = desVel_x(:,j);
    end
end



desVel_y = ones(MensaSize);

end