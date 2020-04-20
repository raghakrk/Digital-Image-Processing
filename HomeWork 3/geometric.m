clc;clear all;close all;
img=readraw('lighthouse.raw',512,512);
[r,c]=size(img);
Ib=zeros(r,c);
sub1=readraw('lighthouse1.raw',256,256);
sub2=readraw('lighthouse2.raw',256,256);
sub3=readraw('lighthouse3.raw',256,256);
% [subx,suby,sub1o]=sobel(sub1);
Io1=trsfrm(sub1,3);
Io2=trsfrm(sub2,2);
Io3=trsfrm(sub3,1);

for i=1:r
    for j=1:c
        if img(i,j)<255
            Ib(i,j)=0;
        else
            Ib(i,j)=1;
        end
    end
end
hitmiss=ones(160,160);
img1=zeros(r,c);
w=1;
bound=zeros(2,3);
for i=1:352
    for j=1:352
        cnt=0;
        a=1;
        csum=0;
        for p=i:i+159
            b=1;
            for q=j:j+159
                if Ib(p,q) && hitmiss(a,b)==1;
                   cnt=cnt+1;
                   continue;
                else
                    break;
                end
                b=b+1;
            end
            a=a+1;
            if cnt==160*160
                bound(1,w)=i;
                bound(2,w)=j;
                w=w+1;
            end
        end
    end
end
Io=img;
for i=1:160
    for j=1:160
        Io(i+bound(1,1)-1,j+bound(2,1)-1)=Io2(i,j);
        Io(i+bound(1,2)-1,j+bound(2,2)-1)=Io1(i,j);
        Io(i+bound(1,3)-1,j+bound(2,3)-1)=Io3(i,j);
    end
end
figure;imshow(uint8(Io))
Ig=imgaussfilt(Io);
imshow(uint8(Ig))