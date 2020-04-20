clear all;clc;close all;
filename="C:\Users\Raghak Krishnan\Desktop\EE569\Week 1\HW1\HW1_images\pepper_uni.raw";
filename_org="C:\Users\Raghak Krishnan\Desktop\EE569\Week 1\HW1\HW1_images\pepper.raw";
img_or=readraw(filename_org);
imgi=readraw(filename);
[X,Y]=size(imgi);

% m=5;
k=1;
for m=3:2:29
    imgg=zeros(X,Y);
    imga=zeros(X,Y);
    clear img;
    img=refl_img(imgi,m);
    Fa=zeros(m,m);
    Fg=zeros(m,m);
    
    x=floor(m/2);
    for i=1:m
        for j=1:m
            Fa(i,j)=1/(m*m);
        end
    end
    sig=1;
    for i=1:m
        for j=1:m
            Fg(i,j)=(1/(2*pi*(sig)^2))*exp(-1*((i-x-1)^2+(j-x-1)^2)/(2*(sig)^2));
        end
    end

    imga=mask_conv(img,m,Fa);
    imgg=mask_conv(img,m,Fg);
    Psnr_a(k)=returnPSNR(imga,img_or);
    Psnr_g(k)=returnPSNR(imgg,img_or);
    k=k+1;
end

figure;imshow(uint8(img_or));
title('original image');
% imsave
figure;imshow(uint8(imgi));
title('Noisy image');
% imsave
figure;imshow(uint8(imga));
title('Uniform weight filter with filter size 5');
% imsave
figure;imshow(uint8(imgg));
title('Gaussian weight filter with filter size 5');
imsave


figure;
stem([3:2:29],Psnr_a);
xticks([3:2:29]);
xlabel('Window size');
ylabel('PSNR(in dB)');
title('PSNR vs Window size for average filter')

figure;
stem([3:2:29],Psnr_g);
xticks([3:2:29]);
xlabel('Window size');
ylabel('PSNR(in dB)');
title('PSNR vs Window size for Gaussian filter')

