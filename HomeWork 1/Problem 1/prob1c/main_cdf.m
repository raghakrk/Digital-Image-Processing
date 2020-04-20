clc;clear all;close all;
filename="C:\Users\Raghak Krishnan\Desktop\EE569\Week 1\HW1\HW1_images\rose_mix.raw";
img=readraw(filename);
[r,c]=size(img);
Pdo=zeros(1,256);
Cdo=zeros(1,256);
m=ones(1,256);
for i=1:r
    for j=1:c
        for k=0:255
            if img(i,j)==k
               x=m(k+1);
               rr(k+1,x)=i;
               cc(k+1,x)=j;
               x=x+1;
               m(k+1)=x;
            end
        end
    end
end
x=1;y=1;
[r1,c1]=size(cc);
for i=1:r1
   for j=1:c1
       if cc(i,j)~=0
            newr(x)=rr(i,j);
            newc(x)=cc(i,j);
            x=x+1;
       end
   end
end
rsize=(r*c)/256;
imgo=zeros(r,c);
p=1;
for k=1:256
    for l=p:625*k  
        imgo(newr(l),newc(l))=k-1;
    end
    p=625*k+1;
end


for i=1:r
    for j=1:c
        for k=0:255
            if imgo(i,j)==k
               Pdo(k+1)=Pdo(k+1)+1;
            end
        end
    end
end
Pdo=Pdo./(r*c);
Cdo(1)=Pdo(1);
for i=2:256
    Cdo(i)=Pdo(i)+Cdo(i-1);
end

figure;
stem([0:255],(r*c).*Pdo,'g');
title('PDF of histogram equalized image (rose_bright.raw) [Using Bucket filling]');
xlabel('Intensity values  (0-255)');
ylabel('No of pixels');
xlim([0 256]);

figure;
plot([0:255],Cdo,'b');
title('CDF of histogram equalized image (rose_bright.raw) [Using Bucket filling]');
xlabel('Intensity values  (0-255)');
ylabel('No of pixels');
xlim([0 256]);
figure;
imshow(uint8(img));
imsave
figure;
imshow(uint8(imgo));
% imsave
% 
