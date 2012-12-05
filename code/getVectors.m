function [VectorX, VectorY] = getVectors(Size)

maxForce = 100;
HorDivisions = 200;
Parts = Size/HorDivisions;

%% Forces on agents in direction x 
VectorX = zeros(Size);

% For the bottom
for i = 1:Size/2
    % left part of the mensa,
    for j = 1:Parts
        % create a Force to the right 
        % proportional to agents distance from center
        for m = 0:(HorDivisions/2 - 1)
            VectorX(Size/2 + i, Parts*m + j) = ...
                floor( maxForce - maxForce*( m/(HorDivisions/2-1) ) );
        end
    end
end
        
% For the bottom right part, create a Force to the left
VectorX(:, ((Size/2)+1) : Size) = -fliplr( VectorX(:, 1:(Size/2) ) );

% After agents pay, they may move again towards the sides
VectorX(1: (Size/2) ,:) = -flipud( VectorX( ((Size/2)+1) : Size ,:));


%% Forces on agents in direction y
VectorY = ones(Size);

end