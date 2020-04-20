clear all;clc;close all;
filename="C:\Users\Raghak Krishnan\Desktop\EE569\Week 1\HW1\HW1_images\pepper_dark_noise.raw";
filename_org="C:\Users\Raghak Krishnan\Desktop\EE569\Week 1\HW1\HW1_images\pepper_dark.raw";
img_or=readraw(filename_org);
imgi=readraw(filename);
[X,Y]=size(imgi);

m=3;
x=floor(m/2);
imgz=zeros(X,Y);
imgp=zeros(X,Y);
for i=1:X
    for j=1:Y
        imgz(i,j)=2*sqrt(imgi(i,j)+ (3/8));
    end
end

img=refl_img(imgz,m);
Fg=zeros(m,m);

sig=1;
for i=1:m
    for j=1:m
        Fg(i,j)=(1/(2*pi*(sig)^2))*exp(-1*((i-x-1)^2+(j-x-1)^2)/(2*(sig)^2));
    end
end


imgg=mask_conv(img,m,Fg);
for i=1:X
    for j=1:Y
        imgp(i,j)=((((imgg(i,j))^2)/4)-(3/8));
    end
end

figure;imshow(uint8(img_or));
title('original image');
imsave
figure;imshow(uint8(imgi));
title('Noisy image');
imsave

figure;imshow(uint8(imgp));
title('Gaussian weight filter with Anscombe transform with filter size 3');
imsave

PSNRi=returnPSNR(imgp,img_or);

