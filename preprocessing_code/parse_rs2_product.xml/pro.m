clear; 
clc;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%this code is used for extract lon, lat inf for 8x8 downsampling images and save them to centain directory 
cd /home/lein/yan_thesis/raw_data/2011_2012/rs2
dirs = dir('RS2*');

for i = 1:numel(dirs)
    
    cd /home/lein/yan_thesis/raw_data/2011_2012/rs2

    
    ncfile = [dirs(i).name '/test_im_latlon.nc' ];
    day = dirs(i).name(36:36+14);
    
    ncid=netcdf.open(ncfile,'NOWRITE');
    %ncid=netcdf.open('RS2_OK47589_PK461345_DK410893_SCWA_20140126_223850_HH_HV_SGF_HV_reprojected.nc.gz','NOWRITE');
    [numdims, numvars, numlatts, unlimdimID] = netcdf.inq(ncid);
    [dimname1,dimlength]=netcdf.inqDim(ncid,0);
    [dimname2,dimlength]=netcdf.inqDim(ncid,1);
    %[dimname2,dimlength]=netcdf.inqDim(ncid,2);


    [varname1,xtype,dimid,natt]=netcdf.inqVar(ncid,0);
     [varname2,xtype,dimid,natt]=netcdf.inqVar(ncid,1);
    % [varname3,xtype,dimid,natt]=netcdf.inqVar(ncid,2);
    lat=double(netcdf.getVar(ncid,0));
    lon=double(netcdf.getVar(ncid,1));
    % lon= double(netcdf.getVar(ncid,2)); # 8x8 downsampling as did for
    % original
    lat2 = imresize(lat,0.125);
    lon2 = imresize(lon, 0.125);
 

    cd /home/lein/yan_thesis/raw_data/2011_2012/lat_lon/
    fname1 =strcat(day,'_lat','.mat')
    fname2 =strcat(day,'_lon','.mat')
    save(fname1,'lat2');
    save(fname2,'lon2');
end


