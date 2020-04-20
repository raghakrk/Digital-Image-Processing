function sobelcolor(filename, height,width,T)
[IR,IG,IB]=readraw_rgb(filename,height,width);

[X,Y]=size(IR);
I=zeros(X,Y);
Ix=zeros(X,Y);Iy=zeros(X,Y);
Io=zeros(X,Y);
In=zeros(X,Y);
It=zeros(X,Y);
Fx=(1/4)*[-1 0 1;-2 0 2;-1 0 1];
Fy=(1/4)*[-1 -2 -1;0 0 0;1 2 1];
mask=3;
m=floor(mask/2);

for i=1:X
    for j=1:Y
        I(i,j)=0.299 * IR(i,j) + 0.587 * IG(i,j) + 0.114 * IB(i,j);
    end
end
% I=I./255;
for i=m+1:X-m
    for j=m+1:Y-m
        k=1;
        csumx=0;csumy=0;
        for p=i-m:i+m       
            l=1;
            for q=j-m:j+m  
                csumx=csumx+(I(p,q)*Fx(k,l));
                csumy=csumy+(I(p,q)*Fy(k,l));
                l=l+1;
            end
            k=k+1;
            Ix(i,j)=csumx;Iy(i,j)=csumy;
            Io(i,j)=sqrt(csumx^2+csumy^2);
        end
    end 
end
In=norm_img(Io);
Ixn=norm_img(Ix);
Iyn=norm_img(Iy);
% Tt=64;Tp=55;
T=round(T*255);
for i=1:X
    for j=1:Y
            if(In(i,j)>T)
                It(i,j)=0;
            else
                It(i,j)=255; 
            end
    end
end

figure;imshow(uint8(In));
title('The Sobel edge detector')
% imsave
figure;imshow(uint8(It));
title('Edge map of Sobel edge detector')
% imsave
figure;imshow(uint8(Ixn));
title('The x Gradient');
% imsave
figure;imshow(uint8(Iyn));
title('The y Gradient');
% imsave
% save('sobel_pig','It');
writeraw(It,'sobel_out.raw');
end