clear
clc
close all;
%imshow(IA)
%pred from softmax  -b<x<a
% in this case a=18.0569 b=5.4042  threshold=b/(b+a)
% 5.4042/(5.4042+18.0569)=0.2302 for 20140124_103501
%threshold for 20140124_215646 is  =0.2362 


SAR=imread('/home/lein/yan_thesis/raw_data/hhv/20140128_101751-HH-8by8-mat.tif');

name1=importdata('/home/lein/yan/caffe/finetunning_thesis/try20170916/results/14_name_1.mat');
pred1=importdata('/home/lein/yan/caffe/finetunning_thesis/try20170916/results/14_1_regression.mat')';
name2=importdata('/home/lein/yan/caffe/finetunning_thesis/try20170916/results/14_name_2.mat');
pred2=importdata('/home/lein/yan/caffe/finetunning_thesis/try20170916/results/14_2_regression.mat')';
name3=importdata('/home/lein/yan/caffe/finetunning_thesis/try20170916/results/14_name_3.mat');
pred3=importdata('/home/lein/yan/caffe/finetunning_thesis/try20170916/results/14_3_regression.mat')';


name = [name1; name2; name3];
pred=[pred1;pred2;pred3];
pred = pred*5
labels=[];

s=0
for ii=1:size(name)
    
    char=name(ii,:);
    if s<size(char);
    s=size(char)
    end;
end;
    

for ii=1:size(pred)
    
    char=name(ii,:);
    
    schar=char(19:22);
   
    if schar(2)=='.'
        schar(2)=' ';
        schar(3)=' ';
        schar(4)=' ';
    end;
    if schar(3)=='.'
        schar(3)=' ';
        schar(4)=' ';
    end;
    if schar(4)=='.'
       schar(4)=' ';
    end;
    q(ii,:)=schar;
end;

D=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for ii=1:size(pred)
  ww=q(ii,:);
    www=str2num(ww);
    qq(ii,:)=www;

C(ii,1)=qq(ii,1);
C(ii,2)=pred(ii,1);%C contains ice probability and patch number.
C(ii,3)= str2num(name(ii));

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
for i1=45:20:m-45
    for j1=45:20:n-45
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


imshow(uint8(ImSAR));

hold on;

for i2=1:size(CC, 1)
    
    
    CC(i2,3)=E(CC(i2,1),1);
    CC(i2,4)=E(CC(i2,1),2);
    row=CC(i2,3);
    column= CC(i2,4);
    
    
end;

a2=50;
% the probability map
scatter(CC(:,4),CC(:,3),a2, CC(:,2),'filled');
title('Regression map for 20140128_101751');
colormap('jet')

figure;
imshow(uint8(ImSAR));
hold on;
scatter(CC(:,4),CC(:,3),a2, labels(:),'filled');
title('ground truth for 20140128_101751')
colormap('jet')