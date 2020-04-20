clear all;clc;close all;
filename="C:\Users\Raghak Krishnan\Desktop\EE569\Week 1\HW1\HW1_images\pepper_uni.raw";
imgi=readraw(filename);
[X,Y]=size(imgi);
ms=3;
mb=51;
% sig1=1;sig2=1;
img=refl_img(imgi,mb+ms-1);
imgo=filtmask_conv(img,mb,ms);
% Psnr_o(k)=returnPSNR(imgo,imgi);

% figure;imshow(uint8(imgi));
figure;imshow(uint8(imgo));
imsave


