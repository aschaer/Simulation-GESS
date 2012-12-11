function potential = getMensa(visual)

C = imread('Mensa.png');
potential = flipud(double(C));

[width, height] = meshgrid(1:1000,1:1000);

% % 3D View
% MensaMap = figure('Name','Mensa Polyterasse Model');
% mesh(width, height, potential)
% colorbar
% colormap([1 0 0; 0 1 0; 0 0 1]);
% set(MensaMap,'Position',[67 380 560 420])

% Display the mensa (view from above)
if visual
    MensaContour = figure('Name','Mensa Contour');
    mesh(width, height, potential);
    view([0 0 1])
    colorbar
    colormap([1 1 1; .5 .5 .5; 0 0 0]);
    set(MensaContour,'Position',[400 380 560 420]);
    pause(3)
    close(MensaContour);
end

end