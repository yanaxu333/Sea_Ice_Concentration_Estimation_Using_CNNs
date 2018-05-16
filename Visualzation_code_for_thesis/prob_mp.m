clear
clc
close all;
%imshow(IA)
%pred from softmax  -b<x<a
% in this case a=18.0569 b=5.4042  threshold=b/(b+a)
% 5.4042/(5.4042+18.0569)=0.2302 for 20140124_103501
%threshold for 20140124_215646 is  =0.2362 


SAR=imread('/home/lein/yan_thesis/raw_data/hhv/20140122_095247-HV-8by8-mat.tif');
ASI=imread('/home/lein/yan_thesis/raw_data/ASI/20140122_095247.png');
SAR333=imread('/home/lein/yan_thesis/raw_data/hhv/20140122_095247-HV-8by8-mat.tif');

[m333,n333]=size(SAR333);
SAR333(1:45,:)=100;
SAR333(m333-45:m333,:)=100;
SAR333(:,1:45)=100;
SAR333(:,n333-45:n333)=100;

ImSAR333=[];
ImSAR333(:,:,1)=SAR333;
ImSAR333(:,:,2)=SAR333;
ImSAR333(:,:,3)=SAR333;

name = importdata('/home/lein/yan/caffe/finetunning_thesis/partial/2_par/results/6_img_name.mat');
pred=importdata('/home/lein/yan/caffe/finetunning_thesis/partial/2_par/results/6_regression.mat');
%pred = 10*pred/55
pred=pred';
labels=[];

for i=1:size(pred)
    if pred(i,1)>10
        pred(i,1) = 10;
    end;
end;

lenth333=size(name,2)
for ii=1:size(name)
    
    char=name(ii,:);
    char2=char(2);
    if char2=='0'
        schar = char(20:lenth333)
       
    else
        schar= char(19:lenth333);
    end;
    schar= schar(find(~isspace(schar)));
    schar = schar(1:(size(schar,2)-4));
    schar = str2num(schar);
    q(ii,:)=schar;
end;

D=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for ii=1:size(pred)

C(ii,1)=q(ii,1);
C(ii,2)=pred(ii,1);%C contains ice probability and patch number.

if name(ii,2)=='0'
    gdlabel='10'
else
    gdlabel =name(ii)
end;


C(ii,3)= str2num(gdlabel);

end;


D=C;
D(:,3)= [];
labels=sortrows(C);
labels=labels(:,3);
CC= sortrows(D);



[m,n]=size(SAR);
% pred_im=zeros(m,n);
% pred_im(:,:)=100;

    ct=0;
for i1=45:4:m-45
    for j1=45:4:n-45
        ct=ct+1;
       
  E(ct,1)=i1;
  E(ct,2)=j1;
    end;
end;

SAR(1:45,:)=100;
SAR(m-45:m,:)=100;
 SAR(:,1:45)=100;
 SAR(:,n-45:n)=100;


ImSAR=[];
ImSAR(:,:,1)=SAR;
ImSAR(:,:,2)=SAR;
ImSAR(:,:,3)=SAR;


ASI(1:45,:,1:3)=100;
ASI(m-45:m,:,1:3)=100;
ASI(:,1:45,1:3)=100;
ASI(:,n-45:n,1:3)=100;




for i2=1:size(CC, 1)
    
    
    CC(i2,3)=E(CC(i2,1),1);
    CC(i2,4)=E(CC(i2,1),2);
    row=CC(i2,3);
    column= CC(i2,4);
    
    
end;

imshow(uint8(ImSAR));
hold on;
a2=5;
% the probability map
scatter(CC(:,4),CC(:,3),a2, CC(:,2),'filled');colorbar
%title('20140210_103911 Regression map');
colormap('jet')
colorbar('off')

figure;
imshow(uint8(ImSAR));
hold on;
scatter(CC(:,4),CC(:,3),a2, labels(:),'filled'); colorbar
set(gca, 'Clim',[0, 10])
%title('20140210_103911ground truth')
colormap('jet')
colorbar('off')
figure;
imshow(ASI)

% calculate the eculidience distance
diff=0;
for i=1:size(labels)
    diff=diff +(CC(i,2)-labels(i,1))^2;
end;

dis =diff/(size(labels,1)*100)
percent = sqrt(dis)