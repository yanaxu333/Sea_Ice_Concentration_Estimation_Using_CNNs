%***********************************************************************
%load files
%the function of this program is as to extract patches for three classes 
%consolidated ice: 80%-100%
%marginal ice 20% to 80%
%open water: <20%
%another fuction is to do mirroring in order to reduce land containmination

%***********************************************************************
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
for q13=1
    
    %this is the working directory where all the generateded patches are
    %located
    cd /home/lein/patches/ex/
    
    
    newdir=num2str(q13);
    [status, msg, msgID] = mkdir(newdir);
    cd(newdir)
    
HV = imread(hvname(q13,:));
HH = imread(hhname(q13,:));
IAg = imread(incident_angle(q13,:));
IA =double(imread(ice_chart(q13,:)));

[m,n]=size(IA);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%parameter: 
%count1==how many water patches
%count2==how many marginal ice patches
%coutn3==how many consolidated ice patches
%countAll== total patches extrached from this scene
%countRep== represents the 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%extract patches which contains no land points 
count0=0;
count1=0;
count2=0;
count3=0;
count4=0;
count5=0;
count6=0;
count7=0;
count8=0;
count9=0;
count10=0;
countAll=0;
%% %%%%%%%%%%%%%%%%
%do mirroring for several patches
%condition 1: the center points must not be the land point, as we need find
%the label for patches from ice analysis chart.
%%%%%%%%%%%%%%%%%%
%%if less than half of the patch contains land, do mirroring 
        %if more than half of the patch contains land, discard it 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

countRep=0;
%% you can change the stride value here.
for i1=45:4:m-45     %here
    for j1=45:4:n-45  %and here!!!!!!!!!!!!!!!!
        D2=[];
        countRep=countRep+1;
       
       lable=IA(i1,j1);
       if ~isnan(lable)
  
        ic2=IA((i1-22):(i1+22),(j1-22):(j1+22));
        a=HV((i1-22):(i1+22),(j1-22):(j1+22));
        b=HH((i1-22):(i1+22),(j1-22):(j1+22));
        c=IAg((i1-22):(i1+22),(j1-22):(j1+22));
      
        icc2=isnan(ic2);
         %if there are no land points in the patch, then we directly save
        %that patches.
    
       %%%%%%%%%%%%%%%%%%%%%%%%        
        if sum(sum(icc2))==0
        D(:,:,1)=b;
        D(:,:,2)=a;
        D(:,:,3)=c; 
        D=uint8(D);
        wwww=patch_name(q13,:);  
        fname2=strcat(num2str(lable),num2str(wwww),num2str(countRep),'.jpg');
        if lable==0
           count0=count0+1;
           newdir2=num2str(lable);
           [status, msg, msgID] = mkdir(newdir2);
           cd(newdir2)
           imwrite(D,fname2,'jpg');
           cd ..
        end;
        %----------------------
        if lable==1
           count1=count1+1;
           newdir2=num2str(lable);
           [status, msg, msgID] = mkdir(newdir2);
           cd(newdir2)
           imwrite(D,fname2,'jpg');
           cd ..
        end;
        %----------------------        
        if lable==2
            count2=count2+1;
            newdir2=num2str(lable);
            [status, msg, msgID] = mkdir(newdir2);
            cd(newdir2)
            imwrite(D,fname2,'jpg');
            cd ..
        end;
        %----------------------
        if lable==3
            count3=count3+1;
            newdir2=num2str(lable);
            [status, msg, msgID] = mkdir(newdir2);
            cd(newdir2)
            imwrite(D,fname2,'jpg');
            cd ..
        end;
        
        %----------------------
        if lable==4
           count4=count4+1;
           newdir2=num2str(lable);
           [status, msg, msgID] = mkdir(newdir2);
           cd(newdir2)
           imwrite(D,fname2,'jpg');
           cd ..
        end;
         %----------------------
        if lable==5
            count5=count5+1;
            newdir2=num2str(lable);
            [status, msg, msgID] = mkdir(newdir2);
            cd(newdir2)
            imwrite(D,fname2,'jpg');
            cd ..
        end;
         %----------------------
        if lable==6
            count6=count6+1;
            newdir2=num2str(lable);
            [status, msg, msgID] = mkdir(newdir2);
            cd(newdir2)
            imwrite(D,fname2,'jpg');
            cd ..
        end;
        
         %----------------------
        if lable==7
            count7=count7+1;
            newdir2=num2str(lable);
            [status, msg, msgID] = mkdir(newdir2);
            cd(newdir2)
            imwrite(D,fname2,'jpg');
            cd ..
        end;
         %----------------------
        if lable==8
            count8=count8+1;
            newdir2=num2str(lable);
            [status, msg, msgID] = mkdir(newdir2);
            cd(newdir2)
            imwrite(D,fname2,'jpg');
            cd ..
        end;
         %----------------------
        if lable==9
            count9=count9+1;
            newdir2=num2str(lable);
            [status, msg, msgID] = mkdir(newdir2);
            cd(newdir2)
            imwrite(D,fname2,'jpg');
            cd ..
        end;
         %----------------------
        if lable==10
            count10=count10+1;
            newdir2=num2str(lable);
            [status, msg, msgID] = mkdir(newdir2);
            cd(newdir2)
            imwrite(D,fname2,'jpg');
            cd ..
        end;
        countAll=countAll+1;
        end;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        %if patches contains land then execute the following
        if sum(sum(icc2))>0
        %land mirroring 
        %center point in 45*45 patches is (23,23)
        % 对角线对称,上下对称,左右对称, 还是没法消除nan的点就等于了ic2(23,23)所对应的点.
        % 因为ic2(23,23)的点一定不会是land, 因为这个是patch 的标签. 实际上处理的是各个通道的
        % HH.HV 和incidence angle 会有land 在里面,所以需要mirroring, 把land的像素点换成
        %相似的ice或water points       
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        ic3=[];
        ic3=ic2;
        for i=1:45
            for j=1:45
                if isnan(ic3(i,j))
                    ic3(i,j)=ic3(2*23-i,2*23-j);
                    a(i,j)=a(2*23-i,2*23-j);
                    b(i,j)=b(2*23-i,2*23-j);
                    c(i,j)=c(2*23-i,2*23-j);
                end;
                 if isnan(ic3(i,j))
                    ic3(i,j)=ic3(2*23-i,j);
                    a(i,j)=a(2*23-i,j);
                    b(i,j)=b(2*23-i,j);
                    c(i,j)=c(2*23-i,j);
                 end;
                   if isnan(ic3(i,j))
                    ic3(i,j)=ic3(i,2*23-j);
                    a(i,j)=a(i,2*23-j);
                    b(i,j)=b(i,2*23-j);
                    c(i,j)=c(i,2*23-j); 
                 end;
                 if isnan(ic3(i,j))
                    ic3(i,j)=ic3(23,23);
                    a(i,j)=a(23,23);
                    b(i,j)=b(23,23);
                    c(i,j)=c(23,23);
                 end;
                 
            end;
        end; 
        
        D2(:,:,1)=b;
        D2(:,:,2)=a;
        D2(:,:,3)=c; 
        D2=uint8(D2);
        wwww=patch_name(q13,:);  
        fname2=strcat(num2str(lable),num2str(wwww),num2str(countRep),'.jpg');
        


        if lable==0
           count0=count0+1;
           newdir2=num2str(lable);
           cd(newdir2)
           imwrite(D,fname2,'jpg');
           cd ..
        end;
        %----------------------
        if lable==1
           count1=count1+1;
           newdir2=num2str(lable);
          
           cd(newdir2)
           imwrite(D,fname2,'jpg');
           cd ..
        end;
        %----------------------        
        if lable==2
            count2=count2+1;
            newdir2=num2str(lable);
      
            cd(newdir2)
            imwrite(D,fname2,'jpg');
            cd ..
        end;
        %----------------------
        if lable==3
            count3=count3+1;
            newdir2=num2str(lable);
           
            cd(newdir2)
            imwrite(D,fname2,'jpg');
            cd ..
        end;
        
        %----------------------
        if lable==4
           count4=count4+1;
           newdir2=num2str(lable);
           
           cd(newdir2)
           imwrite(D,fname2,'jpg');
           cd ..
        end;
         %----------------------
        if lable==5
            count5=count5+1;
            newdir2=num2str(lable);
            
            cd(newdir2)
            imwrite(D,fname2,'jpg');
            cd ..
        end;
         %----------------------
        if lable==6
            count6=count6+1;
            newdir2=num2str(lable);
           
            cd(newdir2)
            imwrite(D,fname2,'jpg');
            cd ..
        end;
        
         %----------------------
        if lable==7
            count7=count7+1;
            newdir2=num2str(lable);
            
            cd(newdir2)
            imwrite(D,fname2,'jpg');
            cd ..
        end;
         %----------------------
        if lable==8
            count8=count8+1;
            newdir2=num2str(lable);
            
            cd(newdir2)
            imwrite(D,fname2,'jpg');
            cd ..
        end;
         %----------------------
        if lable==9
            count9=count9+1;
            newdir2=num2str(lable);
            
            cd(newdir2)
            imwrite(D,fname2,'jpg');
            cd ..
        end;
         %----------------------
        if lable==10
            count10=count10+1;
            newdir2=num2str(lable);
            
            cd(newdir2)
            imwrite(D,fname2,'jpg');
            cd ..
        end;
       

      end;

    end

    end;
    
    %note here I have 2 imwrite, one for pure patches, one for patches
    %after executing mirroring
end;
end;


count1
count2
count3
countAll
