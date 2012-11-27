close all;
clear all;
clc;

C = imread('Mensa.png');
D = double(C);


[width, height] = meshgrid(1:1000,1:1000);
MensaMap = figure('Name','Mensa Polyterasse Model');
mesh(width, height, D)
colorbar
colormap([1 0 0; 0 1 0; 0 0 1]);
set(MensaMap,'Position',[67 380 560 420])


MensaContour = figure('Name','Mensa Contour');
mesh(width, height, D)
view([0 0 1])
colorbar
colormap([1 0 0; 0 1 0; 0 0 1]);
set(MensaContour,'Position',[627 380 560 420])




