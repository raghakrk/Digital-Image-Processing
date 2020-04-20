function [f, fn]=feature_extract(img,FB,fsize)
    x=floor(fsize/2);
    imgr=ncpy(img,fsize);
    [r,c]=size(img);
    [X,Y]=size(imgr);
    f=zeros(length(FB),1);
    for k=1:length(FB)
        F=FB{k};
        for i=x+1:X-x
            for j=x+1:Y-x
                a=1;
                csum=0;
                for p=i-x:i+x
                    b=1;
                    for q=j-x:j+x
                        csum=csum+imgr(p,q)*F(a,b);
                        b=b+1;
                    end
                    a=a+1;
                end
                f(k)=f(k)+abs(csum);
            end
        end
    end
    f=(1/(r*c)).*f;
    fn=(f-mean(f))./(std(f));
    
end
