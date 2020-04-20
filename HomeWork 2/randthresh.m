
function randthresh(filename, method, height,width)

img=readraw(filename,height,width);
[X,Y]=size(img);
imgo=zeros(X,Y);

for i=1:X
    for j=1:1:Y
        if img(i,j)<=randi([0 255])
            imgo(i,j)=0;
        else
            imgo(i,j)=255;
        end   
    end
end
imshow(uint8(imgo));
writeraw(imgo,'Random_thresholding_out.raw')
end
