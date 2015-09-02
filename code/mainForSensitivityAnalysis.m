% Script for Sensitivity Analysis
% James Doss-Gollin, Francisco de Assis de Souza Filho, Osny E da Silva
% June 2014-Feb 2015
% 
%    Using this tool is very simple. Each section contains code that will 
%    run a sensitivity analysis for a different variable
% 
%    To run, simply position cursor in the first section ("begin program"),
%    run section. Then position cursor in section corresponding to desired
%    variable and select "run section" again.
% 
%    Simply pressing "Run" or 'F5' will generate analysis for all variables

%% Begin Program and Load Data
close all; clc;clear
display('Beginning Program')

% Load Input Data: Rainfall, Roof Size, Post Coordinates
fprintf('\nLoading data...') %for user's benefit
data_path='./data'; %path of saved data
const=declarations();
[data,precip]=getData(data_path,const);
fprintf('Complete\n') %data successfully loaded

%% Sensitivity Analysis for Runoff Coefficient

variable.name='Runoff Coefficient';
variable.val=linspace(0.7,1,5);
fprintf('\n\nSensitivity Analysis for %s\n', variable.name)

for j=1:length(variable.val)
     const = declarations();
     const.runoff=variable.val(j);
     fprintf('%s = %.3f\n\n',variable.name,variable.val(j))
     for i=1:length(data.roof_area)
          rel_post_roof(:,i)=cBalance(precip,data,const,i);
          mean_rel(i,j)=nanmean(rel_post_roof(:,i));
          fprintf('\nRoof: %.1f m^2\t\tMean Reliability: %.4f',...
               data.roof_area(i),mean_rel(i,j))          
     end
end

fprintf('\n\nSensitivity Analysis Complete\n\n')
csvwrite(['Results/' variable.name],mean_rel)

%% Sensitivity Analysis for First-Flush Discard

variable.name='First-Flush Discard';
variable.val=linspace(0,2,5);
fprintf('\n\nSensitivity Analysis for %s\n', variable.name)

for j=1:length(variable.val)
     const = declarations();
     const.ffdisc=variable.val(j);
     fprintf('\n%s = %.3f\n',variable.name,variable.val(j))
     for i=1:length(data.roof_area)
          rel_post_roof(:,i)=cBalance(precip,data,const,i);
          mean_rel(i,j)=nanmean(rel_post_roof(:,i));
          fprintf('\nRoof: %.1f m^2\t\tMean Reliability: %.4f',...
               data.roof_area(i),mean_rel(i,j))          
     end
end

fprintf('\n\nSensitivity Analysis Complete\n\n')
csvwrite(['Results/' variable.name],mean_rel)

%% Sensitivity Analysis for Cistern Volume

variable.name='Cistern Volume';
variable.val=1000*[8,16,30,50];
fprintf('\n\nSensitivity Analysis for %s\n', variable.name)

for j=1:length(variable.val)
     const = declarations();
     const.vcmax=variable.val(j);
     fprintf('\n%s = %.3f\n',variable.name,variable.val(j))
     for i=1:length(data.roof_area)
          rel_post_roof(:,i)=cBalance(precip,data,const,i);
          mean_rel(i,j)=nanmean(rel_post_roof(:,i));
          fprintf('\nRoof: %.1f m^2\t\tMean Reliability: %.4f',...
               data.roof_area(i),mean_rel(i,j))          
     end
end

fprintf('\n\nSensitivity Analysis Complete\n\n')
csvwrite(['Results/' variable.name],mean_rel)

%% Sensitivity Analysis for Alternate Consumption Rule #1

variable.name='Rainy-Season-Consumption';
variable.val=74.1*linspace(0,1,5);
fprintf('\n\nSensitivity Analysis for %s\n', variable.name)

for j=1:length(variable.val)
     const = declarations();
     const.opt.consumption_rule=1;
     const.cons_rainy=variable.val(j);
     fprintf('\n%s = %.3f\n',variable.name,variable.val(j))
     for i=1:length(data.roof_area)
          rel_post_roof(:,i)=cBalance(precip,data,const,i);
          mean_rel(i,j)=nanmean(rel_post_roof(:,i));
          fprintf('\nRoof: %.1f m^2\t\tMean Reliability: %.4f',...
               data.roof_area(i),mean_rel(i,j))          
     end
end

fprintf('\n\nSensitivity Analysis Complete\n\n')
csvwrite(['Results/' variable.name],mean_rel)

%% Sensitivity Analysis for Drinking-Water-Only

variable.name='Drinking-Water-Only';
variable.val=5*linspace(0,15,6);
fprintf('\n\nSensitivity Analysis for %s\n', variable.name)

for j=1:length(variable.val)
     const = declarations();
     const.opt.consumption_rule=2;
     const.cons_yearround=variable.val(j);
     fprintf('\n%s = %.3f\n',variable.name,variable.val(j))
     for i=1:length(data.roof_area)
          rel_post_roof(:,i)=cBalance(precip,data,const,i);
          mean_rel(i,j)=nanmean(rel_post_roof(:,i));
          fprintf('\nRoof: %.1f m^2\t\tMean Reliability: %.4f',...
               data.roof_area(i),mean_rel(i,j))          
     end
end

fprintf('\n\nSensitivity Analysis Complete\n\n')
csvwrite(['Results/' variable.name],mean_rel)