%***********************************************************************
%load files
%the function of this program is as to extract patches for three classes 
%consolidated ice: 80%-100%
%marginal ice 20% to 80%
%open water: <20%
%another fuction is to do mirroring in order to reduce land containmination

%***********************************************************************
if 0
clc
clear
addpath(genpath('/home/lein/yan_thesis/raw_data'))
hhname=importdata('/home/lein/yan_thesis/finetuning/readfile/HHname.txt');
hhname=cell2mat(hhname);

hvname=importdata('/home/lein/yan_thesis/finetuning/readfile/HVname.txt');
hvname=cell2mat(hvname);

incident_angle=importdata('/home/lein/yan_thesis/finetuning/readfile/IAg.txt');
incident_angle=cell2mat(incident_angle);

ice_chart=importdata('/home/lein/yan_thesis/finetuning/readfile/IA_im.txt');
ice_chart=cell2mat(ice_chart);

patch_name=importdata('/home/lein/yan_thesis/finetuning/readfile/pname.txt');
patch_name=cell2mat(patch_name);

%%%%%%%%%%%%%%%%
for q13=4
    
    %this is the working directory where all the generateded patches are
    %located
    cd /home/lein/patches/patches_10_mirroring/samples
    
    
    newdir=num2str(q13);
    [status, msg, msgID] = mkdir(newdir);
    cd(newdir)
    
HV = imread(hvname(q13,:));
HH = imread(hhname(q13,:));
IAg = imread(incident_angle(q13,:));
IA =double(imread(ice_chart(q13,:)));

[m,n]=size(IA);

end;

for i=1:m
    for j=1:n
        
            IA(i,j)=IA(i,j)*(255/11);
     
    end;
end;

imshow(uint8(IA));
colormap('jet');

end;

         