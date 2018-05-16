%generate 8by8 downsampling SAR images
clc
clear
close all

cd /home/lein/yan_thesis/raw_data/2011_2012/rs2

dirs = dir('RS2*');


for i = 1:numel(dirs)
    
    fhh = [dirs(i).name '/imagery_HH.tif' ];
    fhv = [dirs(i).name '/imagery_HV.tif'];
    day = dirs(i).name(36:36+14);
    %copyfile(fhh, [day '_HH.tif']);
    im = imread(fhh);
    im = imresize(im,0.125);
    
    imwrite(im,[day '-HH-8by8-mat.tif'])
    im = imread(fhv);
    im = imresize(im,0.125);
    
    imwrite(im,[ day '-HV-8by8-mat.tif'])
    
end


