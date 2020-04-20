function In=norm_img(Io)
    [X,Y]=size(Io);
    xmax=max(max(Io));
    xmin=min(min(Io));

    for i=1:X
        for j=1:Y
            In(i,j)=(Io(i,j)-xmin)*(255)/(xmax-xmin);
        end
    end
end