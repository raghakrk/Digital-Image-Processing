function warping(filename,R,C)
        img=readraw(filename,R,C);
        [R,C]=size(img);
        figure;imshow(uint8(img));hold on;
        T1=zeros(R,C);
        T4=zeros(R,C);
        T3=zeros(R,C);
        T2=zeros(R,C);
        h=128;
        %%area 1
        u1=C/2;v1=R/2;x1=u1;y1=v1;
        u2=C-C/4;v2=R/4;x2=u2;y2=v2;
        u3=C/4;v3=R/4;x3=u3;y3=v3;
        u4=C;v4=1;x4=u4;y4=v4;
        u5=C/2;v5=1;x5=u5;y5=v5+h;
        u6=1;v6=1;x6=u6;y6=v6;
        ab_coeff1=[u1 u2 u3 u4 u5 u6;v1 v2 v3 v4 v5 v6]*inv([1 1 1 1 1 1;x1 x2 x3 x4 x5 x6;y1 y2 y3 y4 y5 y6;x1^2 x2^2 x3^2 x4^2 x5^2 x6^2 ;x1*y1 x2*y2 x3*y3 x4*y4 x5*y5 x6*y6;y1^2 y2^2 y3^2 y4^2 y5^2 y6^2]);
        scatter([u1 u2 u3 u4 u5 u6],[v1 v2 v3 v4 v5 v6],'r','filled');
        scatter([x1 x2 u3 x4 x5 x6],[y1 y2 y3 y4 y5 y6],'b','filled');
       
        %%area 2
        u1=C/2;v1=R/2;x1=256;y1=256;
        u2=C-C/4;v2=R-R/4;x2=u2;y2=v2;
        u3=C-C/4;v3=R/4;x3=u3;y3=v3;
        u4=C;v4=R;x4=u4;y4=v4;
        u5=C;v5=R/2;x5=u5-h;y5=v5;
        u6=C;v6=1;x6=u6;y6=v6;
        ab_coeff2=[u1 u2 u3 u4 u5 u6;v1 v2 v3 v4 v5 v6]*inv([1 1 1 1 1 1;x1 x2 x3 x4 x5 x6;y1 y2 y3 y4 y5 y6;x1^2 x2^2 x3^2 x4^2 x5^2 x6^2 ;x1*y1 x2*y2 x3*y3 x4*y4 x5*y5 x6*y6;y1^2 y2^2 y3^2 y4^2 y5^2 y6^2]);
        scatter([u1 u2 u3 u4 u5 u6],[v1 v2 v3 v4 v5 v6],'r','filled');
        scatter([x1 x2 u3 x4 x5 x6],[y1 y2 y3 y4 y5 y6],'b','filled');
       
        %%area 3
        u1=C/2;v1=R/2;x1=u1;y1=v1;
        u2=C/4;v2=R-R/4;x2=u2;y2=v2;
        u3=C-C/4;v3=R-R/4;x3=u3;y3=v3;
        u4=1;v4=R;x4=u4;y4=v4;
        u5=C/2;v5=R;x5=u5;y5=v5-h;
        u6=C;v6=R;x6=u6;y6=v6;
        ab_coeff3=[u1 u2 u3 u4 u5 u6;v1 v2 v3 v4 v5 v6]*inv([1 1 1 1 1 1;x1 x2 x3 x4 x5 x6;y1 y2 y3 y4 y5 y6;x1^2 x2^2 x3^2 x4^2 x5^2 x6^2 ;x1*y1 x2*y2 x3*y3 x4*y4 x5*y5 x6*y6;y1^2 y2^2 y3^2 y4^2 y5^2 y6^2]);
        scatter([u1 u2 u3 u4 u5 u6],[v1 v2 v3 v4 v5 v6],'r','filled');
        scatter([x1 x2 u3 x4 x5 x6],[y1 y2 y3 y4 y5 y6],'b','filled');
        
        %%area 4
        u1=C/2;v1=R/2;x1=u1;y1=v1;
        u2=C/4;v2=R/4;x2=u2;y2=v2;
        u3=C/4;v3=R-R/4;x3=u3;y3=v3;
        u4=1;v4=1;x4=u4;y4=v4;
        u5=1;v5=R/2;x5=u5+h;y5=v5;
        u6=1;v6=R;x6=u6;y6=v6;
        ab_coeff4=[u1 u2 u3 u4 u5 u6;v1 v2 v3 v4 v5 v6]*inv([1 1 1 1 1 1;x1 x2 x3 x4 x5 x6;y1 y2 y3 y4 y5 y6;x1^2 x2^2 x3^2 x4^2 x5^2 x6^2 ;x1*y1 x2*y2 x3*y3 x4*y4 x5*y5 x6*y6;y1^2 y2^2 y3^2 y4^2 y5^2 y6^2]);
        scatter([u1 u2 u3 u4 u5 u6],[v1 v2 v3 v4 v5 v6],'r','filled');
        scatter([x1 x2 u3 x4 x5 x6],[y1 y2 y3 y4 y5 y6],'b','filled');hold off;
        clear X Y
        Io=zeros(R,C);
        for i=1:R
            for j=1:C
                if  i<=C-j+1 && i<=j 
                    T1(i,j)=img(i,j);
                    UV=ab_coeff1*[1;j;i;j^2;i*j;i^2];
                    u=round(UV(1));v=round(UV(2));
                    if u>0 && u<513 && v>0 && v<513
                    Io(i,j)=img(v,u);
                    end
                elseif i>j && i<=C-j+1
                    T4(i,j)=img(i,j) ;
                    UV=ab_coeff4*[1;j;i;j^2;i*j;i^2];
                    u=round(UV(1));v=round(UV(2));
                    if u>0 && u<513 && v>0 && v<513
                    Io(i,j)=img(v,u);
                    end
                elseif i>j && i>C-j+1
                    T3(i,j)=img(i,j);
                    UV=ab_coeff3*[1;j;i;j^2;i*j;i^2];
                    u=round(UV(1));v=round(UV(2));
                    if u>0 && u<513 && v>0 && v<513
                    Io(i,j)=img(v,u);
                    end
                elseif  i>C-j+1 &&i<=j 
                    T2(i,j)=img(i,j) ;
                    UV=ab_coeff2*[1;j;i;j^2;i*j;i^2];
                    u=round(UV(1));v=round(UV(2));
                    if u>0 && u<513 && v>0 && v<513
                    Io(i,j)=img(v,u);
                    end
                end   
            end
        end
        figure;
        imshow(uint8(Io));
        writeraw(Io, 'warping.raw');
end


