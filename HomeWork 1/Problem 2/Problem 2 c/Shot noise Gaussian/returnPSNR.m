function PSNR  = returnPSNR( Y,X)
    [r,c]=size(X);
    MSE=0;
    for i=1:r
        for j=1:c
            m = ((Y(i,j)-X(i,j))^2)/(r*c);
            MSE=MSE+m;
        end
    end
    PSNR=10*log10((255*255)/MSE);
end
