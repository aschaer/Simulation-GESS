function [FX,FY,rowW,colW,rowE,colE] = rdImggetVct()
exit=0;
while exit==0
    [FileName,PathName] = uigetfile('*.bmp', 'Select a Bitmap File');
    imMatx=imread(strcat(PathName,FileName));
    exit=1;
     if (find(imMatx>15))
         exit=0;
         uiwait(msgbox('Wrong file'));
     end
end
%%
%Read colors from imMatx and give specific values in this positions

space=find(imMatx==15);
payDesk=find(imMatx==10);
exit=find(imMatx==9);
student=find(imMatx==12);
wall=find(imMatx==0);
[n,m]=size(imMatx);
F=zeros(n,m);
F(space)=1;
F(payDesk)=3;
F(exit)=Inf;
F(student)=2;
F(wall)=0;
F=flipud(F);
%%
%Find the Exits and save the position in raw and col matrix
[rowE,colE] = find(F==Inf);

%Create a new Space with only 1(Space) and 0(Wall) as entries
[sx,sy]=size(F);
NewF=ones(sx,sy);
Wall=find(F==0);
NewF(Wall)=0;


Exits(1,:)=rowE';
Exits(2,:)=colE';

options.nb_iter_max = Inf;
[D,S] = perform_fast_marching(NewF, Exits, options);


% Gradient
[a b]=size(D);

FX=zeros(a,b);
FY=zeros(a,b);
caseX=0;
caseY=0;

%Cases: W=Wall  °=Point to be handled
%  1.  W ° W
%  2.  W ° °

[rowW,colW] = find(NewF==0);

%%
%Controls that the image is correct (not needed for the simulation)
% hold on
% 
% %Plot Walls
% 
% for n=1:1:size(rowW)
%    h = plot(colW(n),rowW(n),'.','Color',[0 0 0]); set(h, 'MarkerSize', 20);
% end
% 
% 
% %Plot Exits
% for n=1:1:size(rowE)
%    h = plot(colE(n),rowE(n), '.r'); set(h, 'MarkerSize', 20);
% end
% 
% hold off
%%
% Prepare the Vectorfield


for m = 1:a    %y-direction
    for n = 1:b   %x-direction
        
        %X-Direction
        if (D(m,n)~=Inf) %Point is no wall element
            if(n>1 && n<b) %No element at the boarder of the matrix
                if(D(m,n-1)==Inf && D(m,n+1)==Inf)
                    caseX=1;
                elseif (D(m,n-1)==Inf)
                    caseX=2;
                elseif (D(m,n+1)==Inf)
                    caseX=3;
                else
                    caseX=4;
                end
            elseif (n<b) %Element at the lower boarder of the matrix
                if(D(m,n+1)==Inf)
                    caseX=1;
                else
                    caseX=2;
                end
            else %Element at the upper boarder of the matrix
                if(D(m,n-1)==Inf)
                    caseX=1;
                else
                    caseX=3;
                end
            end

            
        else %Point is a wall element
            if(n>1 && n<b) %No element at the boarder of the matrix
                if(D(m,n-1)==Inf && D(m,n+1)==Inf)
                    caseX=5;
                elseif (D(m,n-1)==Inf)
                    caseX=6;
                elseif (D(m,n+1)==Inf)
                    caseX=7;
                else
                    caseX=8;
                end
            elseif (n<b) %Element at the lower boarder of the matrix
                if(D(m,n+1)==Inf)
                    caseX=5;
                else
                    caseX=6;
                end
            else %Element at the upper boarder of the matrix
                if(D(m,n-1)==Inf)
                    caseX=5;
                else
                    caseX=7;
                end
            end

        end 
        
        switch caseX
            case 1
                FX(m,n)=0;
            case 2
                FX(m,n)=(D(m,n)-D(m,n+1));
            case 3
                FX(m,n)=(D(m,n-1)-D(m,n));
            case 4
                FX(m,n)=(D(m,n-1)-D(m,n+1))/2;
            case 5
                FX(m,n)=0;
            case 6
                FX(m,n)=0;
            case 7
                FX(m,n)=0;
            case 8
                FX(m,n)=0;
        end
        

        
        
        %Y-Direction
        if (D(m,n)~=Inf) %Point is no wall element
            if(m>1 && m<a) %No element at the boarder of the matrix
                if(D(m-1,n)==Inf && D(m+1,n)==Inf)
                    caseY=1;
                elseif (D(m-1,n)==Inf)
                    caseY=2;
                elseif (D(m+1,n)==Inf)
                    caseY=3;
                else
                    caseY=4;
                end
            elseif (m<a) %Element at the lower boarder of the matrix
                if(D(m+1,n)==Inf)
                    caseY=1;
                else
                    caseY=2;
                end
            else %Element at the upper boarder of the matrix
                if(D(m-1,n)==Inf)
                    caseY=1;
                else
                    caseY=3;
                end
            end

            
        else %Point is a wall element
            if(m>1 && m<a) %No element at the boarder of the matrix
                if(D(m-1,n)==Inf && D(m+1,n)==Inf)
                    caseY=5;
                elseif (D(m-1,n)==Inf)
                    caseY=6;
                elseif (D(m+1,n)==Inf)
                    caseY=7;
                else
                    caseY=8;
                end
            elseif (m<a) %Element at the lower boarder of the matrix
                if(D(m+1,n)==Inf)
                    caseY=5;
                else
                    caseY=6;
                end
            else %Element at the upper boarder of the matrix
                if(D(m-1,n)==Inf)
                    caseY=5;
                else
                    caseY=7;
                end
            end

        end 
        
        switch caseY
            case 1 %  W ° W
                FY(m,n)=0;
            case 2 %  W ° °
                FY(m,n)=(D(m,n)-D(m+1,n));
            case 3 %  ° ° W
                FY(m,n)=(D(m-1,n)-D(m,n));
            case 4 %  ° ° °
                FY(m,n)=(D(m-1,n)-D(m+1,n))/2;
            case 5 %  I I I
                FY(m,n)=0;
            case 6 %  I I °
                FY(m,n)=0;
            case 7 %  ° I I
                FY(m,n)=0;
            case 8 %  ° I °
                FY(m,n)=0;
        end
        % Current Point: °    Wall: W   Infinity:I 

    end
end


%Normalization

[a,b]=size(FX);

for m = 1:a
    for n = 1:b
        if (FX(m,n)~=0 && FY(m,n)~=0)
            FX(m,n)=(FX(m,n)/(sqrt(FX(m,n)^2+FY(m,n)^2)));
            FY(m,n)=(FY(m,n)/(sqrt(FX(m,n)^2+FY(m,n)^2)));
        elseif(FX(m,n)~=0)
            FX(m,n)=(FX(m,n)/abs(FX(m,n)));
            FY(m,n)=0;
        elseif(FY(m,n)~=0)
            FX(m,n)=0;
            FY(m,n)=(FY(m,n)/abs(FY(m,n)));
        end
    end
end

D(D==Inf)=0; % Make infinity entries of D to 0

end