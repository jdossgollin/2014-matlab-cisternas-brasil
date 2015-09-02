function precip_unfiltered=makePrecipMatrix(data_path,const)
%
%    precip_unfiltered=makePrecipMatrix(data_path,const)
%
%    Generates a 3D matrix of daily precipitation values with dimensions
%   [year,day,post]
% 
%    data_path: the directory containing raw data files
%    const: struct containing model parameters
% 
%    precip_unfiltered: output daily precipitation matrix


% step 1: check if data on coordinates and precipitation exists, if not load
% it and save to file

load([data_path '/data_unfiltered']) %get info for each post

ndays = 366; %make space for leap year
npost = length(data_unfiltered.post_num); %number of posts
nyrs = const.data_end-const.data_begin+1; %start and end date of data set

precip_unfiltered = nan(nyrs,ndays,npost); %all days are stored as
     %NaN unless data from file can over-write it
fdir = [data_path '/INMET/']; %directory containing data files for each post
% as .mat must be named by each post as per readINMET.m

wb=waitbar(0,'Making precip matrix.. may take a while');
for p=1:npost %do for each post
     filename = num2str(data_unfiltered.post_num(p));
     load([fdir filename '.mat']); %load file
     %NB: each file carries name of post but the contained variable is 'B'
     %each 'B' has 2 columns: first is a datenum and the second is
     %the corresponding precipitation amount (mm)
     ndays = size(B,1);
     for i=1:ndays %do for each day
          [y,m0,d0]=datevec(B(i,1)); %extract the date
          d=datenum(y,m0,d0)-datenum(y,1,1)+1; %day #d of the year
          precip_unfiltered(y-const.data_begin+1,d,p) = B(i,2);
               %store data into precip
     end
     waitbar(p/npost)
end
close(wb)
save([data_path '/precip_unfiltered.mat'],'precip_unfiltered');

end