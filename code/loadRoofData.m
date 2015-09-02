function roof_area=loadRoofData(data_path,const)
% 
% roof_area = (data_path,const)
% 
% data_path: directory of coordinates containing data
% const: model parameters including:
% const.opt.roof_source: governs roof size data used
%         1 for 'default.txt'
%         2 for 'Milha.txt'
%         3 for 'paper2009.txt'
%         4 for command window specification of filename
%             write filename as string; file must be readable using load()
%              include the full path if needed

% Roof data
if(const.opt.roof_source==1)
    roof_area = load([data_path '/Roofs/default.txt']);
elseif(const.opt.roof_source==2)
    roof_area = load([data_path '/Roofs/Milha.txt']);
elseif(const.opt.roof_source==3)
    roof_area = load([data_path '/Roofs/Apaper2009.txt']);
elseif(const.opt.roof_source==4)
    roof_area = load(input(['Write filename here ...'...
        '(see help loaddata for more info):     '],'s'));
end

end