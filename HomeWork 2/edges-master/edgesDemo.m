% Demo for Structured Edge Detector (please see readme.txt first).

%% set opts for training (see edgesTrain.m)
opts=edgesTrain();                % default options (good settings)
opts.modelDir='models/';          % model will be in models/forest
opts.modelFnm='modelBsds';        % model name
opts.nPos=5e5; opts.nNeg=5e5;     % decrease to speedup training
opts.useParfor=0;                 % parallelize if sufficient memory

%% train edge detector (~20m/8Gb per tree, proportional to nPos/nNeg)
tic, model=edgesTrain(opts); toc; % will load model if already trained

%% set detection parameters (can set after training)
model.opts.multiscale=1;          % for top accuracy set multiscale=1
model.opts.sharpen=2;             % for top speed set sharpen=0
model.opts.nTreesEval=1;          % for top speed set nTreesEval=1
model.opts.nThreads=4;            % max number threads for evaluation
model.opts.nms=1;                 % set to true to enable nms

%% evaluate edge detector on BSDS500 (see edgesEval.m)
if(0), edgesEval( model, 'show',1, 'name','' ); end

%% detect edge and visualize results
I = imread('Pig.jpg');
tic, E=edgesDetect(I,model); toc

figure(1); imshow(I); figure(2); imshow(1-E);

[X Y]=size(E);
th=0.1;
for i=1:X
    for j=1:Y
            if(E(i,j)>th)
                EE(i,j)=0;
            else
                EE(i,j)=255; 
            end
    end
end
imshow(uint8(EE))
% [thrs,cntR,sumR,cntP,sumP,V] = edgesEvalImg( E, 'Tiger.mat');
[thrs,cntR,sumR,cntP,sumP,R,P] = perf_eval( E, 'Pig.mat');


xx=find(isnan(P));
P(xx(1):end,:)=[];
R(xx(1):end,:)=[];
F=2*(P.*R)./(P+R);

xaxis=thrs(1:17);
plot(xaxis,F,'DisplayName','F');
title('mean F measure for Pig');
xlabel('Thresholds');
ylabel('mean F measure');
legend('Ground Truth 1','Ground Truth 2','Ground Truth 3','Ground Truth 4','Ground Truth 5');