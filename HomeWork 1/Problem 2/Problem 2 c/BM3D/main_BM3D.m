clc;clear all;close all;
filename_org="C:\Users\Raghak Krishnan\Desktop\EE569\Week 1\HW1\HW1_images\pepper_dark.raw";
filename="C:\Users\Raghak Krishnan\Desktop\EE569\Week 1\HW1\HW1_images\pepper_dark_noise.raw";

img_or=readraw(filename_org);
imgi=readraw(filename);
[X,Y]=size(imgi);

imgz=zeros(X,Y);
imgp=zeros(X,Y);
for i=1:X
    for j=1:Y
        imgz(i,j)=2*sqrt(imgi(i,j)+ (3/8));
    end
end
[p,imgg]=BM3D(img_or,imgi);
imgg=255*imgg;
for i=1:X
    for j=1:Y
        imgp(i,j)=(((imgg(i,j))^2)/4)-(3/8);
    end
end

figure;imshow(uint8((imgp)));
% imsave
PSNRi=returnPSNR(imgi,imgp);

stem(PSNR);
xlim([1 2])
xticks([1 2]);xticklabels(['gaussian','BM3D']);

