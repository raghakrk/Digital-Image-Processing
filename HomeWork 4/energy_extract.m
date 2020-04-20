function FE=energy_extract(img,FB,winsize)
    fsize=length(FB{1});
    x=floor(fsize/2);
    imgr=ncpy(img,fsize);
    [r,c]=size(img);
    FeB=cell(1,length(FB));
    [X,Y]=size(imgr);
    for k=1:length(FB)
        F=FB{k};
        Ao=zeros(r,c);
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
                Ao(i-x,j-x)=csum;
            end
        end
        FeB{k}=Ao;
    end
    x=floor(winsize/2);
    FE=zeros(r,c,length(FB));
    for k=1:length(FB)
        I=FeB{k};
        imgr=ncpy(I,winsize);
        [r,c]=size(I);
        [X,Y]=size(imgr);
        Ao=zeros(r,c);
        for i=x+1:X-x
            for j=x+1:Y-x
                csum=0;
                for p=i-x:i+x
                    for q=j-x:j+x
                        csum=csum+abs(imgr(p,q));
                    end
                end
                Ao(i-x,j-x)=(1/(winsize))*csum;
            end
        end
        FE(:,:,k)=Ao;
    end
end