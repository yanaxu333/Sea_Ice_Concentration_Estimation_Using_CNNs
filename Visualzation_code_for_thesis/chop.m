
%------------------
clear
close all

cd /home/lein/yan/fig
HH= imread('20140122_095247_hv.jpg');
imshow(HH);
a =size(HH);
C1(:,:,1)=HH(500:(a(1)-100),700:(a(2)-100-45),1);
C1(:,:,2)=HH(500:(a(1)-100),700:(a(2)-100-45),2);
C1(:,:,3)=HH(500:(a(1)-100),700:(a(2)-100-45),3);
imshow(C1)
cd /home/lein/Dropbox/uw/figures
fname = 'part1-HV-20140122_095247.jpg'
imwrite(C1,fname,'jpg');


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