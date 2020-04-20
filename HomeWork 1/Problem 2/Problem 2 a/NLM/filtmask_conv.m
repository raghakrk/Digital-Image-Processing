function newimg=filtmask_conv(imgg,mask_bsize,mask_ssize)
    n2=floor(mask_bsize/2);
    n1=floor(mask_ssize/2);
    [X,Y]=size(imgg);
    img1=zeros(X,Y);
    a=5;
    h=25;
    for i=n2+n1+1:X-n2-n1
        for j=n2+n1+1:Y-n2-n1
            fsum=0;csum=0;
            for k=i-n2:i+n2
                for l=j-n2:j+n2
                    w=0;
                    for p=-1*n1:n1 
                        for q=-1*n1:n1 
                            g=(1/(sqrt(2*pi)*a))*exp((-1)*(p^2+q^2)/(2*a^2));
                            t=g*(imgg(i+p,j+q)-imgg(k+p,l+q))^2;
                            w=t+w;
                        end
                    end
                    c=exp((-1*w)/(h*h));
                    F=imgg(k,l)*c;
                    fsum=fsum+F;
                    csum=csum+c;
                end
            end
            img1(i,j)=fsum/csum;
        end
    end
    newimg=round(img1);  
    newimg(X-n2-n1+1:X,:)=[];
    newimg(1:n2+n1,:)=[];
    newimg(:,Y-n2-n1+1:Y)=[];
    newimg(:,1:n2+n1)=[];      
end
