function Io=errdif(I)
F=(1/16)*[0 0 0;0 0 7;3 5 1];
mask=3;
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

end