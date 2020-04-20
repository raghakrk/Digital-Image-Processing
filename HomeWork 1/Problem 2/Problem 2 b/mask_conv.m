function newimg=mask_conv(imgg,mask_size,sigc,sigs)
    x=floor(mask_size/2);
    [X,Y]=size(imgg);
    img1=zeros(X,Y);
    for i=x+1:X-x
        for j=x+1:Y-x
            csum=0;
            wsum=0;
            for p=i-x:i+x
                for q=j-x:j+x
                    w=exp((-1*((i-p)^2+(j-q)^2)/(2*(sigc)^2))-1*((imgg(i,j)-imgg(p,q))^2)/(2*(sigs)^2));
                    csum=csum+imgg(p,q)*w;
                    wsum=wsum+w;
                end
            end
            img1(i,j)=csum/wsum;
        end
    end
    newimg=img1;  
    newimg(X-x+1:X,:)=[];
    newimg(1:x,:)=[];
    newimg(:,Y-x+1:Y)=[];
    newimg(:,1:x)=[];      
end
