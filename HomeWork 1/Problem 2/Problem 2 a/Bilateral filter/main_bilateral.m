clear all;clc;close all;
filename="C:\Users\Raghak Krishnan\Desktop\EE569\Week 1\HW1\HW1_images\pepper_uni.raw";
filename_org="C:\Users\Raghak Krishnan\Desktop\EE569\Week 1\HW1\HW1_images\pepper.raw";
img_or=readraw(filename_org);
imgi=readraw(filename);
[X,Y]=size(imgi);
m=5;
sigc=10;sigs=300;
img=refl_img(imgi,m);
imgo=mask_conv(img,m,sigc,sigs);
Psnr_o=returnPSNR(imgo,imgi);

figure;imshow(uint8(imgi));
figure;imshow(uint8(imgo));
title('Bilateral filtered with sig_c=10,sig_s=300 and mask size=5');
imsave;



