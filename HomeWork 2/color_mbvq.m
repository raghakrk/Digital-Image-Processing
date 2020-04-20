function color_mbvq(filename, height,width)
[IR,IG,IB]=readraw_rgb(filename,height,width);
[X,Y]=size(IR);
IR=IR./255;IG=IG./255;IB=IB./255;
IRo=zeros(X,Y);
IGo=zeros(X,Y);
IBo=zeros(X,Y);
mbvq_type={'CMYW','MYGC','RGMY','KRGB','RGBM','CMGB'};
F=(1/16)*[0 0 0;0 0 7;3 5 1];
mask=3;
Fm=zeros(mask);
for i=1:mask
    for j=1:mask
        Fm(i,j)=F(i,mask-j+1);
    end
end
m=floor(mask/2);


for i=m+1:X-m
    if mod(i,2)==0
        for j=m+1:Y-m
            mbvq=findmbvq(IR(i,j),IG(i,j),IB(i,j));
            [v,vert]=getNearestVertex(mbvq_type{mbvq}, (IR(i,j)), (IG(i,j)), (IB(i,j)));
            IRo(i,j)=v(1);
            IGo(i,j)=v(2);
            IBo(i,j)=v(3);           
            ER=IR(i,j) - v(1);
            EG=IG(i,j) - v(2);
            EB=IB(i,j) - v(3);
            k=1;
            for p=i-m:i+m       
                l=1;
                for q=j-m:j+m  
                    IR(p,q)=IR(p,q)+F(k,l)*ER;
                    IG(p,q)=IG(p,q)+F(k,l)*EG;
                    IB(p,q)=IB(p,q)+F(k,l)*EB;
                    l=l+1;
                end
                k=k+1;
            end
        end 
    else
        for j=Y-m:-1:m+1
            mbvq=findmbvq(IR(i,j),IG(i,j),IB(i,j));
            [v,vert]=getNearestVertex(mbvq_type{mbvq}, (IR(i,j)), (IG(i,j)), (IB(i,j)));
            IRo(i,j)=v(1);
            IGo(i,j)=v(2);
            IBo(i,j)=v(3);
            
            ER=IR(i,j) - v(1);
            EG=IG(i,j) - v(2);
            EB=IB(i,j) - v(3);
            k=1;
            for p=i-m:i+m       
                l=1;
                for q=j-m:j+m  
                    IR(p,q)=IR(p,q)+Fm(k,l)*ER;
                    IG(p,q)=IG(p,q)+Fm(k,l)*EG;
                    IB(p,q)=IB(p,q)+Fm(k,l)*EB;
                    l=l+1;
                end
                k=k+1;
            end
        end 
    end
end

img(:,:,1)=255*IRo;img(:,:,2)=255*IGo;img(:,:,3)=255*IBo;
imshow(uint8(img))

end
