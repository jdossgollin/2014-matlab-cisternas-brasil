function drawMaps(data,rel_by_post,const,roof_area)
%    Function to plot worldmap and histogram for a specified data set
%    of calculated reliability
%   
%    data: header file for each post including longitude and latitude
%    rel_by_post: vector of reliability at each post
%    const: model parameters
%    roof_area: roof size for labeling

if(const.opt.mapcolor==1)
     colormap(hot); %load and set colormap from file
else
     colormap(bone) %default colormap (variation on grayscale)
end

map_path = [const.data_path '/shapefile_brasil/brasil_estados.shp']; %Brazil map location
states = shaperead(map_path,'UseGeoCoords',true); %load shapefile

worldmap(const.latlim,const.lonlim); %open a map

mlabel('off'); plabel('off'); %turn meridian and parallel labels off
grid('on') %turn grid on

geoshow([states.Lat],[states.Lon], 'Color', 'black') %plot the states

scatterm(data.lat,data.lon,const.opt.dot_size,(max(rel_by_post(:,1)...
     -const.opt.mintick,0))./(1-const.opt.mintick),'filled');%add data 

scatterm(data.lat,data.lon,const.opt.dot_size);%encircle dot in black
     % otherwise can be very difficult to see white dots

title(['$A_{C}=$' num2str(roof_area) '$\textup{m}^{2}$'],...
    'Interpreter','latex','FontSize',9);

hcb=colorbar(); caxis([const.opt.mintick,1])
set(hcb,'YTick',linspace(const.opt.mintick,1,6))

end