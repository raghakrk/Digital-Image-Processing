clc;clear all;close all;
[R,G,B]=readraw_rgb('rice.raw',500,690);
I=uint8(cat(3,R,G,B));
Ig=rgb2gray(I);

[r,c]=size(Ig);
Im=medfilt2(Ig,[5 5]);
% figure;imshow(Im);


for i=1:r
    for j=1:c
        if Im(i,j)<79 && Im(i,j)>69 %% && Im(i,j)~=73
            Ib(i,j)=0;
        else
            Ib(i,j)=1;
        end
    end
end
Ib=medfilt2(Ib,[5 5]);
% figure;imshow(Ib);

Ie=imerode(Ib,[0 1 0]);
Ic=bwmorph(Ie,'close');
% imshow(Ic);
If=imfill(Ie,'holes');
figure;
imshow(If)


I1=If(20:140,1:200);
I2=If(20:140,291:490);
I3=If(20:140,491:690);
I4=If(165:285,1:200);
I5=If(165:285,291:490);
I6=If(165:285,491:690);
I7=If(280:400,1:200);
I8=If(280:400,291:490);
I9=If(280:400,491:690);
I10=If(380:500,171:370);
I11=If(380:500,400:599);

c1=pdetect(bwmorph(I1,'shrink',inf));
c2=pdetect(bwmorph(I2,'shrink',inf));
c3=pdetect(bwmorph(I3,'shrink',inf));
c4=pdetect(bwmorph(I4,'shrink',inf));
c5=pdetect(bwmorph(I5,'shrink',inf));
c6=pdetect(bwmorph(I6,'shrink',inf));
c7=pdetect(bwmorph(I7,'shrink',inf));
c8=pdetect(bwmorph(I8,'shrink',inf));
c9=pdetect(bwmorph(I9,'shrink',inf));
c10=pdetect(bwmorph(I10,'shrink',inf));
c11=pdetect(bwmorph(I11,'shrink',inf));
c=c1+c2+c3+c4+c5+c6+c7+c8+c9+c10+c11;

disp(c)

