function readINMET(data_path)
% 
%    readINMET(data_path)
% 
%    Reads precipitation data from .txt file downloadable from INMET 
%    Creates and saves a struct called data_unfiltered to store this 
%    header information. Saves rainfall data from each file as a .mat file 
%    to be read by makePrecipMatrix.m
%  
%    data_path: the path to the data folder
%    const: struct containing model parameters
% 
%    Elements of data_unfiltered are:
%         (1) post_name: stores first word of name as string
%         (2) post_num: number of each post as number
%         (3) lat: latitude of post coordinate
%         (4) lon: longitude of post coordinate
% 
%    This function saves data_unfiltered and a .mat file for each
%    meteorological post but does not return anything

directory=dir([data_path, '/INMET/*.txt']); %structure containing
     %all all text files in the directory
num_file=length(directory);

% Initialize variables to make code faster
data_unfiltered.post_name={}; %post_name of each post
data_unfiltered.post_num=zeros(num_file,1); %post number
data_unfiltered.lon=zeros(num_file,1); %longitude of post
data_unfiltered.lat=zeros(num_file,1); %latitude of post

wb=waitbar(0,'Reading data files from text');

for i=1:num_file   %read each file
    fname=directory(i).name; %get filename
    
    fid=fopen([data_path '/INMET/' fname]); %open file
    header=textscan(fid,'%s',16,'Delimiter','\n'); %read header lines
    header=header{1}(:); %each line of header is {}
    
    data_unfiltered.post_name{i,1}=sscanf(header{4},'Estação%*[ :] %s');
    data_unfiltered.post_num(i,1)=sscanf(header{4},'Estação%*[ :] %*s%*[ABCDEFGHIJKLMNOPQRSTUVWXYZ ] - %*s (OMM: %d)');
    data_unfiltered.lat(i,1)=sscanf(header{5},'Lat%*s  %*s : %f');
    data_unfiltered.lon(i,1)=sscanf(header{6},'Lon%*s %*s : %f');

    fspec='%*d;%d/%d/%d;%*d;%f;'; %format spec for remaining data
    %this data begins at line 17
    %format: [Post #;Day/Month/Year;Time;precip(mm)]
    A=fscanf(fid,fspec);
    C=reshape(A,[4,ceil(length(A)/4)])'; clear('A');
    B=[datenum(C(:,3),C(:,2),C(:,1)),C(:,4)]; %[date precip(mm)]
    save([data_path '/INMET/' num2str(data_unfiltered.post_num(i))],'B');
    %the variable name is 'B' 
    
    fclose(fid);
    waitbar(i/num_file)
end
close(wb)
save([data_path '/data_unfiltered.mat'],'data_unfiltered')

end