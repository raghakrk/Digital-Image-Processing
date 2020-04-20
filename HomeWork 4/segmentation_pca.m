clear all;close all;clc;
img=readraw('C:\Users\Raghak Krishnan\Desktop\EE569\HWs\HW4\HW4_Images\comb.raw',510,510);
[r,c]=size(img);
L5=[1 4 6 4 1];
E5=[-1,-2, 0, 2, 1];
S5=[-1, 0, 2, 0,-1];
W5=[-1, 2, 0,-2, 1];
R5=[1,-4, 6,-4, 1];
K=[L5;E5;S5;W5;R5];
FB=cell(1,25);
l=1;
winsize=39;ndims=3;
for i=1:5
    for j=1:5
        FB{l}=K(j,:).'*K(i,:);
        l=l+1;
    end
end
A=energy_extract(img,FB,winsize);
An=zeros(size(A));
for k=1:length(FB)
    for i=1:r
        for j=1:c
            An(i,j,k)=A(i,j,k)/A(i,j,1);
        end
    end
end
Fr=reshape(An,[r*c,25]);
[coeff,score,latent] = pca(Fr);
pcaval=score(:,1:ndims);

[idx,C] = kmeans(pcaval,7);
Io=reshape(idx,[r,c]);
map = [1 1 0
    1 0 1
    0 1 1
    1 0 0
    0 1 0
    0 0 1
    0 0 0];

II=Io;
II(II==1)=0;
II(II==2)=42;
II(II==3)=84;
II(II==4)=126;
II(II==5)=168;
II(II==6)=210;
II(II==7)=255;

figure;
imshow(uint8(II))
% contourf(Io)
% colormap(map)
% colorbar
title(['Segmentation with PCA dim: ',num2str(ndims),' Window size: ',num2str(winsize)])
imsave
