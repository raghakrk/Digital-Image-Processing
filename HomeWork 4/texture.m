clear all;close all;clc;
T1=readraw('C:\Users\Raghak Krishnan\Desktop\EE569\HWs\HW4\HW4_Images\texture1.raw',128,128);
T2=readraw('C:\Users\Raghak Krishnan\Desktop\EE569\HWs\HW4\HW4_Images\texture2.raw',128,128);
T3=readraw('C:\Users\Raghak Krishnan\Desktop\EE569\HWs\HW4\HW4_Images\texture3.raw',128,128);
T4=readraw('C:\Users\Raghak Krishnan\Desktop\EE569\HWs\HW4\HW4_Images\texture4.raw',128,128);
T5=readraw('C:\Users\Raghak Krishnan\Desktop\EE569\HWs\HW4\HW4_Images\texture5.raw',128,128);
T6=readraw('C:\Users\Raghak Krishnan\Desktop\EE569\HWs\HW4\HW4_Images\texture6.raw',128,128);
T7=readraw('C:\Users\Raghak Krishnan\Desktop\EE569\HWs\HW4\HW4_Images\texture7.raw',128,128);
T8=readraw('C:\Users\Raghak Krishnan\Desktop\EE569\HWs\HW4\HW4_Images\texture8.raw',128,128);
T9=readraw('C:\Users\Raghak Krishnan\Desktop\EE569\HWs\HW4\HW4_Images\texture9.raw',128,128);
T10=readraw('C:\Users\Raghak Krishnan\Desktop\EE569\HWs\HW4\HW4_Images\texture10.raw',128,128);
T11=readraw('C:\Users\Raghak Krishnan\Desktop\EE569\HWs\HW4\HW4_Images\texture11.raw',128,128);
T12=readraw('C:\Users\Raghak Krishnan\Desktop\EE569\HWs\HW4\HW4_Images\texture12.raw',128,128);


L5=[1 4 6 4 1];
E5=[-1,-2, 0, 2, 1];
S5=[-1, 0, 2, 0,-1];
W5=[-1, 2, 0,-2, 1];
R5=[1,-4, 6,-4, 1];
K=[L5;E5;S5;W5;R5];
FB={};
l=1;
for i=1:5
    for j=1:5
        FB{l}=K(j,:).'*K(i,:);
        l=l+1;
    end
end
[f1,fn1]=feature_extract(T1,FB,5);
[f2,fn2]=feature_extract(T2,FB,5);
[f3,fn3]=feature_extract(T3,FB,5);
[f4,fn4]=feature_extract(T4,FB,5);
[f5,fn5]=feature_extract(T5,FB,5);
[f6,fn6]=feature_extract(T6,FB,5);
[f7,fn7]=feature_extract(T7,FB,5);
[f8,fn8]=feature_extract(T8,FB,5);
[f9,fn9]=feature_extract(T9,FB,5);
[f10,fn10]=feature_extract(T10,FB,5);
[f11,fn11]=feature_extract(T11,FB,5);
[f12,fn12]=feature_extract(T12,FB,5);
Fn=[fn1 fn2 fn3 fn4 fn5 fn6 fn7 fn8 fn9 fn10 fn11 fn12];
F=[f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12];

clear fn1 fn2 fn3 fn4 fn5 fn6 fn7 fn8 fn9 fn10 fn11 fn12
clear f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12

ndims=3;
Fn=Fn.';
F=F';
[coeff,score,latent] = pca(Fn);
pcaval=score(:,1:ndims);
% scatter(pcaval(:,1),pcaval(:,2));
tic;
[idx,C] = kmeans(pcaval,4);
toc;
tic;
[idxF,CF] = kmeans(Fn,4);
toc;
figure;
subplot(121)
histogram(idxF,4)
title('Kmeans for 25D vector')
xlabel('Class')
ylabel('Count')
subplot(122)
histogram(idx,4)
title('Kmeans for 3D vector')
xlabel('Class')
ylabel('Count')

figure;
color=['r','g','b','k'];
for k=1:4
    x=find(idx==k);
    scatter3(C(k,1),C(k,2),C(k,3),'*',color(k));hold on;
    scatter3(pcaval(x,1),pcaval(x,2),pcaval(x,3),color(k));
    xlabel('Principal component 1')
    ylabel('Principal component 2')
    zlabel('Principal component 3')
end
hold off;
text(pcaval(:,1),pcaval(:,2),pcaval(:,3),{'p1','p2','p3','p4','p5','p6','p7','p8','p9','p10','p11','p12'})

figure;
color=['r','g','b','k'];
for k=1:4
    x=find(idx==k);
    scatter(CF(k,1),CF(k,2),'*',color(k));hold on;
    scatter(Fn(x,1),Fn(x,2),color(k));
    xlabel('Principal component 1')
    ylabel('Principal component 2')
end
hold off;
text(pcaval(:,1),pcaval(:,2),{'p1','p2','p3','p4','p5','p6','p7','p8','p9','p10','p11','p12'})

cbark=[F(6,:);F(4,:);F(12,:)];
cstraw=[F(2,:);F(8,:)];
cbrick=[F(3,:);F(9,:);F(10,:);F(11,:)];
cbubbles=[F(1,:);F(5,:);F(7,:)];
C={cbark,cstraw,cbrick,cbubbles};
intravar=zeros(4,25);
for i =1:4
   intravar(i,:)=var(C{i}) ;
end
intravar=intravar.';
[~,minintradx]=min(intravar);
[~,maxintradx]=max(intravar);

interdata=[cbark(1,:);cstraw(1,:)];
intervar=var(interdata);
[~,maxinterdx]=max(intervar);
[~,mininterdx]=min(intervar);
