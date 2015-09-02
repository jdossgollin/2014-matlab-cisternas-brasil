% Script to Evaluate Rainwater Capture
% James Doss-Gollin, Francisco de Assis de Souza Filho, Osny E da Silva
% June 2014-March 2015
close all; clc;clear
display('Beginning Program')

%% Declarations
const = declarations();
disp(const); disp(const.opt) %load and display governing 
% parameters as a struct. To edit these parameters, edit declarations.m

% Load Input Data: Rainfall, Roof Size, Post Coordinates
fprintf('\nLoading data...') %for user's benefit
[data,precip]=getData(const.data_path,const);
fprintf('Complete\n') %data successfully loaded

rel_post_roof=zeros(size(precip,3),length(data.roof_area)); %initialize
% rel_post_roof which holds the mean calculated reliability at each post

%% Volume Balance and Draw Maps

for i=1:length(data.roof_area) %loop for each roof size
     rel_post_roof(:,i)=cBalance(precip,data,const,i); %
     if(const.opt.figure_toggle==1)
          subplot(3,2,i)
          drawMaps(data,rel_post_roof(:,i),const,data.roof_area(i));
     end
     fprintf('\nRoof: %.1f m^2\t\tMean Reliability: %.4f',...
          data.roof_area(i),nanmean(rel_post_roof(:,i)))
end

%% Program Conclusion
fprintf('\n\nProgram complete\n')