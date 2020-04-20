function res_img=refl_img(img,m)
    [X,Y]=size(img);
    p=floor(m/2);
    res_img=zeros(X+m-1,Y+m-1);
    res_img(p+1:X+p,p+1:Y+p)=img;
    for i=1:p
       res_img(i,:)=res_img(2*(p+1)-i,:);
       res_img(end+1-i,:)=res_img(end-(2*p+1-i),:);
    end
    for i=1:p
       res_img(:,i)=res_img(:,2*(p+1)-i);
       res_img(:,end+1-i)=res_img(:,end-(2*p+1-i));
    end
end






