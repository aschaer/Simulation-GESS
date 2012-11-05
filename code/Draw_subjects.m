%Disegna soggetti
function []=Draw_subjects(people)
%image=
figure

length_of_people=length(people);
for j=1:length_of_people
    if(people(j))
        for k=1:people(j)
              hold on
              plot(1,k,'o','LineWidth',4)
              pause(0.01)
        end
        hold off
    end
end
disp('Plot done')
