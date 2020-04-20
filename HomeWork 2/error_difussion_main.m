function error_difussion_main(filename, method, height,width)
tic;
% I=readraw('bridge.raw',400,600);
I=readraw(filename,height,width);

% F_fs=(1/16)*[0 0 0;0 0 7;3 5 1];
% F_jjn=(1/48)*[0 0 0 0 0;0 0 0 0 0;0 0 0 7 5;3 5 7 5 3;1 3 5 3  1];
% F_s=(1/42)*[0 0 0 0 0;0 0 0 0 0;0 0 0 8 4;2 4 8 4 2;1 2 4 2 1]
switch method
    case 1 
            mask=3;F=(1/16)*[0 0 0;0 0 7;3 5 1];
        
    case 2
            mask=5;F=(1/48)*[0 0 0 0 0;0 0 0 0 0;0 0 0 7 5;3 5 7 5 3;1 3 5 3  1];
    case 3
            mask=5;F=(1/42)*[0 0 0 0 0;0 0 0 0 0;0 0 0 8 4;2 4 8 4 2;1 2 4 2 1];
        
end
Fm=zeros(mask);

for i=1:mask
    for j=1:mask
        Fm(i,j)=F(i,mask-j+1);
    end
end
m=floor(mask/2);
I=refl_img(I,mask);
[X Y]=size(I);
Io=zeros(X,Y);

% Io=I;
for i=m+1:X-m
    if mod(i,2)==0
        for j=m+1:Y-m
            if I(i,j)<=127
                it=0;
                Io(i,j)=0;
            else
                it=255;
                Io(i,j)=255;
            end
            e=I(i,j)-it;
            k=1;
            for p=i-m:i+m       
                l=1;
                for q=j-m:j+m  
                    I(p,q)=I(p,q)+F(k,l)*e;
                    l=l+1;
                end
                k=k+1;
            end
        end 
    else
        for j=Y-m:-1:m+1
            if I(i,j)<=127
                it=0;
                Io(i,j)=0;
            else
                it=255;
                Io(i,j)=255;
            end
            e=I(i,j)-it;
            k=1;
            for p=i-m:i+m       
                l=1;
                for q=j-m:j+m  
                    I(p,q)=I(p,q)+Fm(k,l)*e;
                    l=l+1;
                end
                k=k+1;
            end
        end 
    end
end
Io(X-m+1:X,:)=[];
Io(1:m,:)=[];
Io(:,Y-m+1:Y)=[];
Io(:,1:m)=[];  


toc;
% figure;
% imshow(uint8(Io))
% imsave
writeraw(Io,'Error_difusion_out.raw');

end