clc;clear all;close all;
filename="C:\Users\Raghak Krishnan\Desktop\EE569\Week 1\HW1\HW1_images\rose_mix.raw";
img=readraw(filename);
[r,c]=size(img)
Pdi=zeros(1,256);
Cdi=zeros(1,256);
Pdo=zeros(1,256);
Cdo=zeros(1,256);

for i=1:r
    for j=1:c
        for k=0:255
            if img(i,j)==k
               Pdi(k+1)=Pdi(k+1)+1;
            end
        end
    end
end
Pdi=Pdi./(r*c);
Cdi(1)=Pdi(1);
for i=2:256
    Cdi(i)=Pdi(i)+Cdi(i-1);
end
imgo=img;
for i=1:r
    for j=1:c
            imgo(i,j)=round(255*Cdi(img(i,j)+1));
    end
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
stem([0:255],(r*c).*Pdi,'b');
title('PDF of Input image (rose_mix.raw)');
xlabel('Intensity values (0-255)');
ylabel('No of pixels');
xlim([0 256]);

figure;
stem([0:255],(r*c).*Pdo,'r');
title('PDF of histogram equalized image (rose_dark.raw) [Using Transfer function]');
xlabel('Intensity values  (0-255)');
ylabel('No of pixels');
xlim([0 256]);

figure;
plot([0:255],255.*Cdo,'b');
title('Transfer function');
xlabel('Gray scale values (0-255)');
ylabel('T(r)')
xlim([0 256]);

figure;
imshow(uint8(img));
% imsave
figure;
imshow(uint8(imgo));
imsave

