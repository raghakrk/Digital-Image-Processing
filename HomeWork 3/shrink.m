% function Im=STS(filename,height,width,method)
%%method S for Shrinking
%%method T for Thinning
%%method K for Skeletonising
function iteration=shrink(I,height,width)
load 'shrinking.mat';
load('thinning.mat')
load('skeleton.mat')
load 'uncond_shr_thin.mat';
load('uncond_skel.mat');
% filename='pattern3';
% I=readraw(filename,height,width);
% I=I./255;
[R,C]=size(I);
flag=0;
B=[1 2 1;2 0 2;1 2 1];
iteration=0;
Im=I;
hit=0;
if nargin<4
    method='S';
end
% method='K';

if method=='S' || method=='s'
    LUT=S;
    UC_LUT=ucond_shr_thin;
elseif method=='T' ||method=='t'
    LUT=T;
    UC_LUT=ucond_shr_thin;
elseif method=='K' || method=='k'
    LUT=K;
    UC_LUT=ucond_skel;
end




while(flag==0)
% while(iteration<=75)
    cnt=0;
    M=zeros(R,C);
    iteration=iteration+1;
    for i=2:R-2
        for j=2:C-2
            if Im(i,j)==1
                bw=B(1,1)*Im(i-1,j-1)+B(1,2)*Im(i-1,j)+B(1,3)*Im(i-1,j+1) + B(2,1)*Im(i,j-1)+B(2,2)*Im(i,j)+B(2,3)*Im(i,j+1) + B(3,1)*Im(i+1,j-1)+B(3,2)*Im(i+1,j)+B(3,3)*Im(i+1,j+1);
                if ~(bw==12 || bw==11 || bw==0)
                     for l=1:size(LUT,2)
                            Ms=LUT{bw,l};
                            if Ms==zeros(3,3) 
                                continue;
                            elseif (Im(i-1,j-1)==Ms(1,1)) && (Im(i-1,j)==Ms(1,2)) && (Im(i-1,j+1)==Ms(1,3))&& (Im(i,j-1)==Ms(2,1))&&(Ms(2,2)==Im(i,j))&& (Ms(2,3)==Im(i,j+1))&& (Ms(3,1)==Im(i+1,j-1)) && (Ms(3,2)==Im(i+1,j)) && (Ms(3,3)==Im(i+1,j+1))
                                    M(i,j)=1;
                                    hit=hit+1;
                                    cnt=cnt+1;
                                    break;
                            end                 
                     end
                end
            end
        end
    end
    for i=2:R-2
        for j=2:C-2
            if M(i,j)==1
                for k=1:length(UC_LUT)
                    UCM=UC_LUT{k};
                    if (M(i-1,j-1)==UCM(1,1)) && (M(i-1,j)==UCM(1,2)) && (M(i-1,j+1)==UCM(1,3))&& (M(i,j-1)==UCM(2,1))&&(UCM(2,2)==M(i,j))&& (UCM(2,3)==M(i,j+1))&& (UCM(3,1)==M(i+1,j-1)) && (UCM(3,2)==M(i+1,j)) && (UCM(3,3)==M(i+1,j+1))
                        hit=hit+1;
                        cnt=cnt+1;
                        Im(i,j)=1;
                        break;
                    else
                        Im(i,j)=0;
                    end
                end
            end
        end
    end
    if cnt==0
       flag=1; 
    end
end
disp(iteration)
if method=='K'
    for i=2:R-2
        for j=2:C-2
            X3=Im(i-1,j-1);X2=Im(i-1,j);X1=Im(i-1,j+1);
            X4=Im(i,j-1);X=Im(i,j);X0=Im(i,j+1);
            X5=Im(i+1,j-1);X6=Im(i+1,j);X7=Im(i+1,j+1);
            L1=~X && ~X0 && X1 && ~X2 && X3 && ~X4 && ~X5 && ~X6 && ~X7;
            L2=~X && ~X0 && ~X1 && ~X2 && X3 && ~X4 && X5 && ~X6 && ~X7;
            L3=~X && ~X0 && ~X1 && ~X2 && ~X3 && ~X4 && X5 && ~X6 && X7;
            L4=~X && ~X0 && X1 && ~X2 && ~X3 && ~X4 && ~X5 && ~X6 && X7;
            Q= L1||L2||L3||L4;
            P1=~X2 && ~X6 && (X3 || X4 || X5) && (X0 || X1 || X7) && ~Q;
            P2=~X0 && ~X4 && (X1 || X2 || X3) && (X5 || X5 || X7) && ~Q;
            P3=~X0 && ~X6 && X7 && (X2 || X3 || X4);
            P4=~X0 && ~X2 && X1 && (X4 || X5 || X6);
            P5=~X2 && ~X4 && X3 && (X0 || X6 || X7);
            P6=~X4 && ~X6 && X5 && (X0 || X1 || X2);
            Im(i,j)=X || (P1 || P2 || P3 || P4 || P5 || P6);

        end
    end
end

end

     
   