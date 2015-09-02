function [data,precip]=getData(data_path,const)
%
%    data=getData(data_path,const)
%
%    Returns a struct data, containing the data for
%    daily rainfall, post coordinates, and roof sizes
% 
%     getData checks to see if filtered data exists. If it does not,
%     it checks to see if unfiltered data exists and filters it. If this
%     does not exist, it reads the data from text files.
% 
%    Note that if important changes are made in declarations.m
%    that affect data filtering, user must manually delete the
%    data.mat file and precip.mat. If new data is added then the 
%    data_unfiltered.mat and precip_unfiltered.mat must be deleted
% 
%    data_path: path in which the raw data is stored 
%    const: struct of model parameters
% 
%    data: structure containing data for each meteorological post
%    precip: matrix of dimensions [year day post] containing daily 
%    rainfall data, filtered for use

% first choice: check if filtered data already exists
if(exist([data_path '/data.mat'],'file'))
     load([data_path '/data.mat']);
     load([data_path '/precip.mat']);
     
     
% second choice: unfiltered data exists
elseif(exist([data_path '/data_unfiltered.mat'],'file'))
     load([data_path '/data_unfiltered.mat']);
     load([data_path '/precip_unfiltered.mat']);
     [data,precip] = filterData(data_unfiltered,precip_unfiltered,const);
     save([data_path '/precip.mat'],'precip') %save precip to file
     save([data_path '/data.mat'],'data') %save data to file
     
     
% third choice: read text files directly from source
else
     readINMET(data_path) %read text files and create
     %data_unfiltered
     load([data_path '/data_unfiltered.mat']) %load data_unfiltered
     %because readINMET does not load it into workspace
     precip_unfiltered=makePrecipMatrix(data_path,const);
     %create precip_unfiltered
     [data,precip] = filterData(data_unfiltered,precip_unfiltered,const);
     save([data_path '/precip.mat'],'precip') %save precip to file
     save([data_path '/data.mat'],'data') %save data to file
     
end

%get roof data
data.roof_area=loadRoofData(data_path,const);

end