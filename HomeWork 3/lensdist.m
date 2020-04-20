clc;close all;clear all;
k1=-0.3536;k2=0.1730;k3=0;
I=readraw('classroom.raw',712,1072);
[r1,c1]=size(I);
Xc=zeros(r1,c1);
Yc=zeros(r1,c1);
Xd=zeros(r1,c1);
Yd=zeros(r1,c1);
uc=c1/2;
vc=r1/2;
for v=1:r1
    for u=1:c1
        xd=(u-uc)/600;%converting to camera coordinate
        yd=(v-vc)/600;
        r=xd^2+yd^2;
        F=(1+k1*r+k2*r^2+k3*r^3);
        xc=xd*F;
        yc=yd*F;
        Xc(v,u)=xc;
        Yc(v,u)=yc;
        Xd(v,u)=xd;
        Yd(v,u)=yd;
    end
end
% ucd=U(1,1);
% vcd=V(1,1);
x=randi(c1,[r1*c1 1]);
y=randi(r1,[r1*c1 1]);
xdt=Xd(1,x)';
ydt=Yd(y,1);
Xct=zeros(r1*c1,1);
Yct=zeros(r1*c1,1);

for i=1:r1*c1
    Xct(i)=Xc(y(i),x(i));
end
for i=1:r1*c1
    Yct(i)=Yc(y(i),x(i));
end

XYd=[xdt ydt];
L=XYd\[Xct Yct];
% Li=inv(L);
clearvars -except I r1 c1 uc vc L
Io=zeros(r1,c1);
Xd=zeros(r1,c1);
Yd=zeros(r1,c1);
for v=1:r1
    for u=1:c1
        xc=(u-uc)/600;%converting to camera coordinate
        yc=(v-vc)/600;
        xyd=(L)*[xc;yc];
        ud=xyd(1)*600+uc+1;vd=xyd(2)*600+vc+1;
        Xd(v,u)=ud;
        Yd(v,u)=vd;
%         Io(v,u)=I(round(vd),round(ud));
        dv=vd-floor(vd);du=ud-floor(ud);
        vce=ceil(vd);vf=floor(vd);
        uce=ceil(ud);uf=floor(ud);
        Io(v,u)=(1-dv)*(1-du)*I(vf,uf)+dv*(1-du)*I(vce,uf)+(1-dv)*du*I(vf,uce)+dv*du*I(vce,uce);      
    end
end
imshow(uint8(I));
figure;imshow(uint8(Io));

