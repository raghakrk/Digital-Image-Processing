clc;clear all;close all;
filename="C:\Users\Raghak Krishnan\Desktop\EE569\Week 1\HW1\HW1_images\cat.raw";
img=readcat(filename);
X=300;Y=390;
m=3;

Fg=(1/4)*[0 1 0;1 4 1;0 1 0];
Fc=(1/4)*[1 2 1;2 4 2;1 2 1];

R = img.*repmat([0 1; 0 0], X/2, Y/2);
G=img.*repmat([1 0;0 1],X/2,Y/2);
B=img.*repmat([0 0;1 0],X/2,Y/2);

R=refl_img(R,m);
G=refl_img(G,m);
B=refl_img(B,m);

R=mask_conv(R,m,Fc);
G=mask_conv(G,m,Fg);
B=mask_conv(B,m,Fc);
[r,c]=size(R);
resimg=zeros(r,c,3);
resimg(:,:,1)=R;
resimg(:,:,2)=G;
resimg(:,:,3)=B;
imag=uint8(resimg);

figure('Name','Raw Image');
imshow(uint8(img));
title('Raw Image');

figure('Name','Bilinear Demosaiced Image');
imshow(imag);
title('Bilinear Demosaiced Image');

% imsave