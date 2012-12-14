%Plotting and saving 
close all
clc
[FX,FY]=rdImggetVct;
%% 
%Prepare plots display
xplots = 3; yplots = 2;
scrsz = get(0, 'ScreenSize');
k=0;
positions = zeros(xplots*yplots,4);
for xp = 1:xplots
    for yp = 1:yplots
        k = k+1;
        positions(k,:) = [(xp-1)*scrsz(3)/xplots (yplots-yp)*...
            scrsz(4)/yplots scrsz(3)/xplots scrsz(4)/yplots]+1;
    end
end

close all
clc
FZ=FX.*FX+FY.*FY;
fignum=1;
fig=figure(fignum);
whitebg(fig,[0 0 0]);
hold on
z=zeros(size(FX));
quiver3(z,FX,FY,FZ)
colormap([0,0,0;0.2,0.5,0])
title('Vectorfield wiew','Fontsize',14)
xlabel('x','Fontsize',14)
ylabel('y','Fontsize',14,'rot',pi/2)
legend('Force Field')
mTextBox = uicontrol('style','text');
set(mTextBox,'String','Walls','BackgroundColor',[0 0 0])
set(mTextBox,'ForegroundColor',[1 1 1],'Position',[80 150 50 20])
set(mTextBox,'Fontsize',14)
set(gcf,'OuterPosition',positions(fignum,:))
saveas(fig,'vecField.eps','psc2')

%% 
fignum=2;
fig2=figure(fignum);
surf(FY)
title('Surf of vectorfield in y direction','Fontsize',14)
t1=colorbar;
set(get(t1,'ylabel'),'string','Norm of Vector','fontsize',14)
view([.5 -1 2])
xlabel('x','Fontsize',14,'Position',[50 -20 0])
ylabel('y','Fontsize',14,'Position',[120 50 0])
set(gcf,'OuterPosition',positions(fignum,:))
saveas(fig2,'vecFieldsurfy.eps','psc2')

%% 
fignum=3;
fig3=figure(fignum);
surf(FX)
title('Surf of vectorfield in x direction','Fontsize',14)
t2=colorbar;
set(get(t2,'ylabel'),'string','Norm of Vector','fontsize',14)
view([0.5 -1 1])
xlabel('x','Fontsize',14,'Position',[50 -20 -1])
ylabel('y','Fontsize',14,'Position',[120 50 -1])
set(gcf,'OuterPosition',positions(fignum,:))
saveas(fig3,'vecFieldsurfx.eps','psc2')

%% 
fignum=4;
fig4=figure(fignum);
surf(FX,FY)
title('Surf of vectorfield seen from [0 0 1]','Fontsize',14)
t3=colorbar;
set(get(t3,'ylabel'),'string','Norm of Vector','fontsize',14)
xlabel('x','Fontsize',14)
ylabel('y','Fontsize',14,'rot',pi/2)
view([0 0 1])
set(gcf,'OuterPosition',positions(fignum,:))
saveas(fig4,'vecFieldsurftot.eps','psc2')


