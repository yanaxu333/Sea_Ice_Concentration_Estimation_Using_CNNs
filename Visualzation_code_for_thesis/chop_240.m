
%------------------
clear
close all


%HH= imread('/home/lein/Desktop/hh.jpg');
%d2014= imread('/home/lein/yan/caffe/finetunning_thesis/mirroring/plots/20140118_101002 regression.jpg');
HH= imread('/home/lein/Desktop/gt.jpg');
pred = imread('/home/lein/Desktop/resul.jpg');
%d2013 = imread('/home/lein/yan/caffe/finetunning_thesis/argu_par_ic/1fold_2013_parIC/plots/20140118_101002_argu_SARs.jpg');

a =size(HH);

%HH=pred;

C1(:,:,1)= HH(100:650,500:850,1);
C1(:,:,2)=HH(100:650,500:850,2);
C1(:,:,3)=HH(100:650,500:850,3);
figure;
imshow(C1)
cd /home/lein/Dropbox/uw/figures

% % cd /home/lein/Dropbox/uw/figures
% % fname = '1002_gt.jpg'
% % 
% % imwrite(C1,fname,'jpg');

% 
% for i=1:size(pre3)
%     if pre3(i,1)>10
%         pre3(i,1) = 10;
%     end;
% end;
% 
% 
% for ii=1:size(pre3)
% 
% C3(ii,1)=pre3(ii,1);%C contains ice probability and patch number.
% 
% if nam3(ii,2)=='0'
%     gdlabel='10'
% else
%     gdlabel =nam3(ii);
% end;
% 
% 
% C3(ii,2)= str2num(gdlabel);
% 
% end;