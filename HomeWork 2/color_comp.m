function Io=color_comp(I)
        [X,Y]=size(I);
        Io=zeros(X,Y);
        for i=1:X
            for j=1:Y
                Io(i,j)=255-I(i,j);
            end
        end 
end