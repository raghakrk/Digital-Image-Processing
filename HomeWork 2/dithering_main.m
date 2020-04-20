function dithering_main(filename,n,height,width)
%     height=400;
%     width=600;
%     filename='bridge.raw';
    tic 
    img=readraw(filename,height,width);
    [X,Y]=size(img);
    imgo=zeros(X,Y);
    I2=[1 2;3 0];
%     n=2;
    m=n^2;
    T=zeros(n,n);
    I=index1(I2,n);
    for i=1:n
        for j=1:n
            T(i,j)=(255/m)*(I(i,j)+0.5);
        end
    end

    for i=1:X
        for j=1:1:Y
            if img(i,j)<=T(mod(i,n)+1,mod(j,n)+1)
                imgo(i,j)=0;
            end
            if img(i,j)>T(mod(i,n)+1,mod(j,n)+1)
                imgo(i,j)=255;
            end   
        end
    end

%     imshow(uint8(imgo))
    writeraw(imgo,['Dithering_I' num2str(n) '_out.raw']);
    toc
end
