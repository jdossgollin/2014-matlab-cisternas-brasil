function [data,precip] = filterData(data_unfiltered,precip_unfiltered,const)
% 
%    [data,precip] = filterData(data_unfiltered,precip_unfiltered,const)
% 
%    Filters data to meet the needs of the program. Checks for:
%         (1) data with sufficient number of usable years; 
%         (2) data within the study area. 
% 
%    data_unfiltered: header information for each meteorological post
%    precip_unfiltered: unfiltered precipitation matrix
% 
%    data: filtered data for each post
%    precip: filtered precipitation matrix

% find which data points are within the Study Area
latok=find(data_unfiltered.lat>const.latlim(1)&...
     data_unfiltered.lat<const.latlim(2)); %coords of posts with
     % latitudes within the specified range
lonok=find(data_unfiltered.lon>const.lonlim(1)&...
     data_unfiltered.lon<const.lonlim(2)); %coords of posts with
     % longitudes within the specified range
     
%find which points have usable data
nyr = size(precip_unfiltered,1);
yerrs=squeeze(366-sum(precip_unfiltered<400 | precip_unfiltered>=0 ,2));
     %returns errors by post and year
     
pok=sum(yerrs<=const.opt.nerrok)'; %number of usable years by post
errsok=find(pok>=const.opt.minyrs); %index of post with at least
     % specified number of usable years of data
     

% find data that meets all requisites (usable points, in study area)
usable=intersect(intersect(latok,lonok,'rows'),errsok,'rows');

% create precip and data
precip=precip_unfiltered(:,:,usable);
data=data_unfiltered;
data.post_name=data_unfiltered.post_name(usable,:);
data.post_num=data_unfiltered.post_num(usable,:);
data.lon=data_unfiltered.lon(usable,:);
data.lat=data_unfiltered.lat(usable,:);

end