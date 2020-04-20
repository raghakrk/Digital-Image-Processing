function newimg=mask_conv(imgg,mask_size,F)
    x=floor(mask_size/2);
    [X,Y]=size(imgg);
    imgg=imgg./255;
    img1=zeros(X,Y);
    for i=x+1:X-x
        for j=x+1:Y-x
            a=1;
            csum=0;
            for p=i-x:i+x
                b=1;
                for q=j-x:j+x
                    csum=csum+imgg(p,q)*F(a,b);
                    b=b+1;
                end
                a=a+1;
            end
            img1(i,j)=csum;
        end
    end
    newimg=round(255.*(img1./(max(max(img1)))));  
    newimg(X-x+1:X,:)=[];
    newimg(1:x,:)=[];
    newimg(:,Y-x+1)=[];
    newimg(:,1:x)=[];    
end
