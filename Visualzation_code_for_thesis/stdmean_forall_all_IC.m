clear
clc
close all;
%imshow(IA)
%pred from softmax  -b<x<a
% in this case a=18.0569 b=5.4042  threshold=b/(b+a)
% 5.4042/(5.4042+18.0569)=0.2302 for 20140124_103501
%threshold for 20140124_215646 is  =0.2362 

name1 = importdata('/home/lein/yan/caffe/finetunning_thesis/mirroring/results/1_img_name.mat');
pred1=importdata('/home/lein/yan/caffe/finetunning_thesis/mirroring/results/1_regression.mat');

name2 = importdata('/home/lein/yan/caffe/finetunning_thesis/mirroring/results/3_img_name.mat');
pred2=importdata('/home/lein/yan/caffe/finetunning_thesis/mirroring/results/3_regression.mat');

name3 = importdata('/home/lein/yan/caffe/finetunning_thesis/mirroring/results/10_img_name.mat');
pred3=importdata('/home/lein/yan/caffe/finetunning_thesis/mirroring/results/10_regression.mat');

name4 = importdata('/home/lein/yan/caffe/finetunning_thesis/mirroring/results/17_img_name.mat');
pred4=importdata('/home/lein/yan/caffe/finetunning_thesis/mirroring/results/17_regression.mat');

name5 = importdata('/home/lein/yan/caffe/finetunning_thesis/mirroring/results/24_img_name.mat');
pred5=importdata('/home/lein/yan/caffe/finetunning_thesis/mirroring/results/24_regression.mat');

%2

name6 = importdata('/home/lein/yan/caffe/finetunning_thesis/222mirroring/results/2_img_name.mat');
pred6=importdata('/home/lein/yan/caffe/finetunning_thesis/222mirroring/results/2_regression.mat');

name7 = importdata('/home/lein/yan/caffe/finetunning_thesis/222mirroring/results/6_img_name.mat');
pred7=importdata('/home/lein/yan/caffe/finetunning_thesis/222mirroring/results/6_regression.mat');

name8 = importdata('/home/lein/yan/caffe/finetunning_thesis/222mirroring/results/15_img_name.mat');
pred8=importdata('/home/lein/yan/caffe/finetunning_thesis/222mirroring/results/15_regression.mat');

name9 = importdata('/home/lein/yan/caffe/finetunning_thesis/222mirroring/results/18_img_name.mat');
pred9=importdata('/home/lein/yan/caffe/finetunning_thesis/222mirroring/results/18_regression.mat');

name10 = importdata('/home/lein/yan/caffe/finetunning_thesis/222mirroring/results/22_img_name.mat');
pred10=importdata('/home/lein/yan/caffe/finetunning_thesis/222mirroring/results/22_regression.mat');

%3
name11 = importdata('/home/lein/yan/caffe/finetunning_thesis/333mirroring/results/4_img_name.mat');
pred11=importdata('/home/lein/yan/caffe/finetunning_thesis/333mirroring/results/4_regression.mat');

name12 = importdata('/home/lein/yan/caffe/finetunning_thesis/333mirroring/results/8_img_name.mat');
pred12=importdata('/home/lein/yan/caffe/finetunning_thesis/333mirroring/results/8_regression.mat');

name13 = importdata('/home/lein/yan/caffe/finetunning_thesis/333mirroring/results/11_img_name.mat');
pred13=importdata('/home/lein/yan/caffe/finetunning_thesis/333mirroring/results/11_regression.mat');

name14 = importdata('/home/lein/yan/caffe/finetunning_thesis/333mirroring/results/20_img_name.mat');
pred14=importdata('/home/lein/yan/caffe/finetunning_thesis/333mirroring/results/20_regression.mat');

name15 = importdata('/home/lein/yan/caffe/finetunning_thesis/333mirroring/results/25_img_name.mat');
pred15=importdata('/home/lein/yan/caffe/finetunning_thesis/333mirroring/results/25_regression.mat');
%4
name16 = importdata('/home/lein/yan/caffe/finetunning_thesis/444mirroring/results/7_img_name.mat');
pred16=importdata('/home/lein/yan/caffe/finetunning_thesis/444mirroring/results/7_regression.mat');

name17 = importdata('/home/lein/yan/caffe/finetunning_thesis/444mirroring/results/9_img_name.mat');
pred17=importdata('/home/lein/yan/caffe/finetunning_thesis/444mirroring/results/9_regression.mat');

name18= importdata('/home/lein/yan/caffe/finetunning_thesis/444mirroring/results/13_img_name.mat');
pred18=importdata('/home/lein/yan/caffe/finetunning_thesis/444mirroring/results/13_regression.mat');

name19 = importdata('/home/lein/yan/caffe/finetunning_thesis/444mirroring/results/19_img_name.mat');
pred19=importdata('/home/lein/yan/caffe/finetunning_thesis/444mirroring/results/19_regression.mat');

name20= importdata('/home/lein/yan/caffe/finetunning_thesis/444mirroring/results/21_img_name.mat');
pred20=importdata('/home/lein/yan/caffe/finetunning_thesis/444mirroring/results/21_regression.mat');
%5
name21 = importdata('/home/lein/yan/caffe/finetunning_thesis/555mirroring/results/5_img_name.mat');
pred21=importdata('/home/lein/yan/caffe/finetunning_thesis/555mirroring/results/5_regression.mat');

name22 = importdata('/home/lein/yan/caffe/finetunning_thesis/555mirroring/results/12_img_name.mat');
pred22=importdata('/home/lein/yan/caffe/finetunning_thesis/555mirroring/results/12_regression.mat');

name23 = importdata('/home/lein/yan/caffe/finetunning_thesis/555mirroring/results/14_img_name.mat');
pred23=importdata('/home/lein/yan/caffe/finetunning_thesis/555mirroring/results/14_regression.mat');

name24 = importdata('/home/lein/yan/caffe/finetunning_thesis/555mirroring/results/16_img_name.mat');
pred24=importdata('/home/lein/yan/caffe/finetunning_thesis/555mirroring/results/16_regression.mat');

name25 = importdata('/home/lein/yan/caffe/finetunning_thesis/555mirroring/results/23_img_name.mat');
pred25=importdata('/home/lein/yan/caffe/finetunning_thesis/555mirroring/results/23_regression.mat');
%1
pre=[pred1'; pred2' ;pred3';pred4'; pred5'; pred7' ;pred8';
    pred9';pred10'; pred12' ;pred13';pred14'; pred15';
    pred16'; pred17';pred19'; pred20';
    pred22';pred23'; pred24';pred25'];
name=[name1;name2; name3; name4; name5;  name7; name8; name9; name10;
  name12; name13; name14; name15;
  name16;name17;  name19; name20;
  name22; name23; name24; name25];

pre2 =[pred6';pred11'];
nam2=[name6;  name11];

pre3=[pred18';pred21'];
nam3=[name18;name21];
%#1
for i=1:size(pre)
    if pre(i,1)>10
        pre(i,1) = 10;
    end;
end;


for ii=1:size(pre)

C1(ii,1)=pre(ii,1);%C contains ice probability and patch number.

if name(ii,2)=='0'
    gdlabel='10'
else
    gdlabel =name(ii);
end;


C1(ii,2)= str2num(gdlabel);

end;
%#2

for i=1:size(pre2)
    if pre2(i,1)>10
        pre2(i,1) = 10;
    end;
end;


for ii=1:size(pre2)

C2(ii,1)=pre2(ii,1);%C contains ice probability and patch number.

if nam2(ii,2)=='0'
    gdlabel='10'
else
    gdlabel =nam2(ii);
end;


C2(ii,2)= str2num(gdlabel);

end;
%#3

for i=1:size(pre3)
    if pre3(i,1)>10
        pre3(i,1) = 10;
    end;
end;


for ii=1:size(pre3)

C3(ii,1)=pre3(ii,1);%C contains ice probability and patch number.

if nam3(ii,2)=='0'
    gdlabel='10'
else
    gdlabel =nam3(ii);
end;


C3(ii,2)= str2num(gdlabel);

end;




%c CONTAIS all labels and predicted labels 
C= [C1;C2;C3]
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


for i=1:size(C)
    
    if C(i,2) == 0;
        count0 =count0+1;
        IC_0(count0,1) = C(i,1);
    end;
   
     if C(i,2) == 1;
        count1 =count1+1;
        IC_1(count1,1) = C(i,1); 
       end;  
       
     if C(i,2) == 2;
        count2 =count2+1;
        IC_2(count2,1) = C(i,1);   
       end;  
     if C(i,2) == 3;
        count3 =count3+1;
        IC_3(count3,1) = C(i,1);
      end;   
     if C(i,2) == 4;
        count4 =count4+1;
        IC_4(count4,1) = C(i,1);        
    end;
      if C(i,2) == 5;
        count5 =count5+1;
        IC_5(count5,1) = C(i,1);     
         end;
        
     if C(i,2) == 6;
        count6 =count6+1;
        IC_6(count6,1) = C(i,1);  
     end;    

     if C(i,2) == 7;
        count7 =count7+1;
        IC_7(count7,1) = C(i,1);      
     end;
        
     if C(i,2) == 8;
        count8 =count8+1;
        IC_8(count8,1) = C(i,1);  
         end;
        
     if C(i,2) == 8;
        count8 =count8+1;
        IC_8(count8,1) = C(i,1); 
         end;
        
     if C(i,2) == 9;
        count9 =count9+1;
        IC_9(count9,1) = C(i,1);       
         end;
        
     if C(i,2) == 10;
        count10 =count10+1;
        IC_10(count10,1) = C(i,1);         
         end;
        
  end;
mea =[mean(IC_0),mean(IC_1),mean(IC_2),mean(IC_3),mean(IC_4), mean(IC_5),mean(IC_6),mean(IC_7),mean(IC_8),mean(IC_9),mean(IC_10)]
stdd=[std(IC_0),std(IC_1),std(IC_2),std(IC_3),std(IC_4), std(IC_5),std(IC_6),std(IC_7),std(IC_8),std(IC_9),std(IC_10)]

Time=0:0.1:1;
errorbar(Time,mea*0.1,stdd*0.1,'rx','LineWidth',2)    
xlabel('Image Analysis Chart');ylabel('Estimation From CNN');
xlim([0 1])
title('Training on all ice concontration')
hold on;
plot([0 1],[0 1],'b','LineWidth',3)
