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


%#1
pred1=pred1';
label1=[];

for i=1:size(pred1)
    if pred1(i,1)>10
        pred1(i,1) = 10;
    end;
end;


for ii=1:size(pred1)

C1(ii,1)=pred1(ii,1);%C contains ice probability and patch number.

if name1(ii,2)=='0'
    gdlabel='10'
else
    gdlabel =name1(ii)
end;


C1(ii,2)= str2num(gdlabel);

end;
%#2

pred2=pred2';

for i=1:size(pred2)
    if pred2(i,1)>10
        pred2(i,1) = 10;
    end;
end;


for ii=1:size(pred2)

C2(ii,1)=pred2(ii,1);%C contains ice probability and patch number.

if name2(ii,2)=='0'
    gdlabel='10'
else
    gdlabel =name2(ii)
end;


C2(ii,2)= str2num(gdlabel);

end;

%#3
pred3=pred3';

for i=1:size(pred3)
    if pred3(i,1)>10
        pred3(i,1) = 10;
    end;
end;


for ii=1:size(pred3)

C3(ii,1)=pred3(ii,1);%C contains ice probability and patch number.

if name3(ii,2)=='0'
    gdlabel='10'
else
    gdlabel =name3(ii)
end;


C3(ii,2)= str2num(gdlabel);

end;
%#4

pred4=pred4';

for i=1:size(pred4)
    if pred4(i,1)>10
        pred4(i,1) = 10;
    end;
end;


for ii=1:size(pred4)

C4(ii,1)=pred4(ii,1);%C contains ice probability and patch number.

if name4(ii,2)=='0'
    gdlabel='10'
else
    gdlabel =name4(ii)
end;


C4(ii,2)= str2num(gdlabel);

end;
%#5
pred5=pred5';

for i=1:size(pred5)
    if pred5(i,1)>10
        pred5(i,1) = 10;
    end;
end;


for ii=1:size(pred5)

C5(ii,1)=pred5(ii,1);%C contains ice probability and patch number.

if name5(ii,2)=='0'
    gdlabel='10';
else
    gdlabel =name5(ii);
end;


C5(ii,2)= str2num(gdlabel);

end;

%c CONTAIS all labels and predicted labels 
C= [C1;C2;C3;C4;C5]
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
%title('Training on all ice concontration 1st fold')
hold on;
plot([0 1],[0 1],'b','LineWidth',3)
