clear all;clc;close all;
L5=[1 4 6 4 1];
E5=[-1,-2, 0, 2, 1];
S5=[-1, 0, 2, 0,-1];
W5=[-1, 2, 0,-2, 1];
R5=[1,-4, 6,-4, 1];
K=[L5;E5;S5;W5;R5];
l1={'L5','E5','S5','W5','R5'};
FB={};
labels={}
l=1;
for i=1:5
    for j=1:i
        fb=K(j,:).'*K(i,:);
        FB{l}=fb
        labels{l}=[l1{i} l1{j}];
        l=l+1;    
    end
end

x = 0.1:0.1:5;
y = x;
[X,Y] = meshgrid(x);
l=1;
figure;
for i=8:12
   if i~=1 && i~=3 && i~=6 && i~=10 && i~=15
       subplot(2,2,l);
       mesh(X,Y,FB{i});
       title(labels{i})
       l=l+1;
   end
%    colorbar;
end

mesh(abs(freqz2(FB{1})));
title(['Frequency response of ',labels{1}])
figure;
subplot(221)
mesh(abs(freqz2(FB{3})));
title(['Frequency response of ',labels{3}])
subplot(222)
mesh(abs(freqz2(FB{6})));
title(['Frequency response of ',labels{6}])
subplot(223)
mesh(abs(freqz2(FB{10})));
title(['Frequency response of ',labels{10}])
subplot(224)
mesh(abs(freqz2(FB{15})));
title(['Frequency response of ',labels{15}])
