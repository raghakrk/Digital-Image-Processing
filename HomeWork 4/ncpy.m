function res_img=ncpy(img,m)
    [X,Y]=size(img);
    p=floor(m/2);
    res_img=zeros(X+m-1,Y+m-1);
    res_img(p+1:X+p,p+1:Y+p)=img-mean2(img);
    for i=1:p
       res_img(i,:)=res_img(p+1,:);
       res_img(end+1-i,:)=res_img(end-(p+1),:);
    end
    for i=1:p
       res_img(:,i)=res_img(:,p+1);
       res_img(:,end+1-i)=res_img(:,end-(p+1));
    end
end






