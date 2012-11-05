%Main File
clear all
close all
clc
t=0:2.5*3600;
incoming_people=Arriving_people(t);
Draw_subjects(incoming_people)