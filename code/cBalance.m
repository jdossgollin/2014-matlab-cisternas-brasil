function rel_by_post = cBalance(precip,data,const,i)
%
%    rel_by_post = cBalance(precip,data,const,i)
%
%    Program to run daily water balance for a group of cisterns sharing
%    a single roof size. Returns average reliability of each post
%
%    precip_data: matrix of precipitation data
%    data: struct containing header data for each coordinate
%    const: struct containing model parameters
%    i: index of roof size to use

[nyr,nday,npost] = size(precip); %number yrs, days, posts
cist_vol=const.starting_volume*ones(npost,1); %initialize cistern 
     % volume at each post

count_dry=zeros(npost,nyr); %1 if given post ran dry on given year, else 0

for y=1:nyr %for each year
     nancount=zeros(npost,1); %track number of missing data values
     for d=1:nday;
          rain=squeeze(precip(y,d,:)); 
          nancount=nancount+isnan(rain); %count missing data points
          rain(isnan(rain))=0; %reset missing data points to zero
          
          cist_vol = min(const.vcmax, cist_vol+(max(rain-const.ffdisc,0))...
               *const.runoff*data.roof_area(i));
          % add rain captured
          
          cist_vol=cist_vol-cConsumption(d,const); % call cConsumption to find
          % consumption, subtract from Vc; same for all posts
          
          if(d>=31) %don't count errors in january, dry season just beginning
               count_dry(:,y)=min(count_dry(:,y)+(cist_vol<0),1); %count errors, but
               %avoid double-counting in a single year
          end
          cist_vol(cist_vol<0)=0; %cannot have negative volume in cistern
     end
     
     count_dry(nancount>const.opt.nerrok,y)=NaN; %check each day for
     % cistern volume less than zero, if it is, set to 0
end

rel_by_post=1-nanmean(count_dry,2);

end