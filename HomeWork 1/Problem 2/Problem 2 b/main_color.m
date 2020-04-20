clear all;clc;close all;
filename_i="C:\Users\Raghak Krishnan\Desktop\EE569\Week 1\HW1\HW1_images\rose_color.raw";
filename_n="C:\Users\Raghak Krishnan\Desktop\EE569\Week 1\HW1\HW1_images\rose_color_noise.raw";

[Ri,Gi,Bi]=readraw(filename_i);
[Rn,Gn,Bn]=readraw(filename_n);
m=5;
sigc=0.5;sigs=25;

imgi(:,:,1)=Ri;imgi(:,:,2)=Gi;imgi(:,:,3)=Bi;
imgn(:,:,1)=Rn;imgn(:,:,2)=Gn;imgn(:,:,3)=Bn;
Rn=refl_img(Rn,m);Gn=refl_img(Gn,m);Bn=refl_img(Bn,m);
Rn=med_conv(Rn,3);Gn=med_conv(Gn,3);Bn=med_conv(Bn,3);

% Rn=medfilt2(Rn,[3 3]);Gn=medfilt2(Gn,[3,3]);Bn=medfilt2(Bn,[3,3]);
Ron=mask_conv(Rn,m,sigc,sigs);Gon=mask_conv(Gn,m,sigc,sigs);Bon=mask_conv(Bn,m,sigc,sigs);
imgo(:,:,1)=Ron;imgo(:,:,2)=Gon;imgo(:,:,3)=Bon;

figure;imshow(uint8(imgi));
imsave;
figure;imshow(uint8(imgn(:,:,3)));
imsave;

figure;imshow(uint8(imgo));
imsave


% [X,Y]=size(imgi);
% m=5;

% sig1=1;sig2=1;
% img=refl_img(imgi,m);
% imgo=mask_conv(img,m,sig1,sig2);
% Psnr_o(k)=returnPSNR(imgo,imgi);
% 
% figure;imshow(uint8(imgi));
% figure;imshow(uint8(imgo));