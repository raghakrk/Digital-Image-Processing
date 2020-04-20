clear all;clc;close all;
filename="C:\Users\Raghak Krishnan\Desktop\EE569\Week 1\HW1\HW1_images\cat.raw";
imgg=readcat(filename);
m=5;
x=floor(m/2);
ka=[-1 -3/2 -1/2 -1];
kb=[2 0 0 4];
kc=[4 6 5 5];
kd=[0 2 -1 -1];
ke=[-1 -3/2 -1 1/2];
kf=[2 0 4 0];
img=refl_img(imgg,m);
[X,Y]=size(img);
R=zeros(X,Y);
G=zeros(X,Y);
B=zeros(X,Y);

for i=x+1:X-x
    for j=x+1:Y-x
        Z=img(i,j);
        P=(1/8)*(ka*(img(i-2,j)+img(i+2,j))+kb*(img(i-1,j)+img(i+1,j))+ kc*img(i,j) + kd*(img(i-1,j-1)+img(i+1,j-1)+img(i-1,j+1)+img(i+1,j+1))+ ke*(img(i,j-1)+img(i,j+1))+kf*(img(i,j-1)+img(i,j+1)));
        if mod(i,2)==1 && mod(j,2)==1
            G(i,j)=Z;
            R(i,j)=P(3);
            B(i,j)=P(4);
        end
        if mod(i,2)==0 && mod(j,2)==0
            G(i,j)=Z;
            R(i,j)=P(4);
            B(i,j)=P(3);
        end
        if mod(i,2)==1 && mod(j,2)==0
            R(i,j)=Z;
            G(i,j)=P(1);
            B(i,j)=P(2);
        end
        if mod(i,2)==0 && mod(j,2)==1
            B(i,j)=Z;
            R(i,j)=P(2);
            G(i,j)=P(1);
        end
    end
end

res_imag(:,:,1)=R(x+1:end-x,x+1:end-x);
res_imag(:,:,2)=G(x+1:end-x,x+1:end-x);
res_imag(:,:,3)=B(x+1:end-x,x+1:end-x);
res_imag=uint8(res_imag);
figure('Name','Raw Image');
imshow(uint8(imgg));
title('MHC Demosaiced Image')
% imsave

figure('Name','MHC Demosaiced Image');
imshow(res_imag);
title('MHC Demosaiced Image')
% imsave