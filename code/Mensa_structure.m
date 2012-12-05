Size=4;
Force=4;
HorDiv = 4;
Parts = floor(Size/HorDiv);
A=zeros(Size);

%A(3,1)=floor(Force/1);
%A(4,1)=floor(Force/2);
%A(3,2)=floor(Force/2);


for i = 1:Size/2
    for j = 1:Parts
        for m = 0:HorDiv/2-1
            A(Size/2 + i, Parts*m + j) = floor(Force/(m+1));
        end

%        A(Size/2 + i, Parts*0 + j) = floor(Force);
%        A(Size/2 + i, Parts*1 + j) = floor(Force);
    end
end


%A(:, ((Size/2)+1) : Size) = -fliplr( A(:, 1:(Size/2) ) );
%A(1: (Size/2) ,:) = -flipud( A( ((Size/2)+1) : Size ,:));