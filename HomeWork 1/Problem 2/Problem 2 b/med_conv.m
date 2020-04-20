function newimg=med_conv(imgg,mask_size)
    x=floor(mask_size/2);
    mm=(mask_size*mask_size+1)/2;
    [X,Y]=size(imgg);
    img1=zeros(X,Y);
    for i=x+1:X-x
        for j=x+1:Y-x
            csum=0;
            wsum=0;
            a=1;
            for p=i-x:i+x
                for q=j-x:j+x
                  z(a)=imgg(i,j);
                  a=a+1;
                end
            end
            z=sort(z);
            img1(i,j)=z(mm);
        end
    end
    newimg=img1;  
    newimg(X-x+1:X,:)=[];
    newimg(1:x,:)=[];
    newimg(:,Y-x+1:Y)=[];
    newimg(:,1:x)=[];      
end
