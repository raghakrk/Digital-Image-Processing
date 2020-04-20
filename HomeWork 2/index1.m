function Inew=index1(I,N)

    if N==2
        Inew=[1 2;3 0];
    else
        nnew=N/2;
        A=zeros(nnew,nnew);
        A=index1(A,nnew);
        
        for i=1:nnew
            for j=1:nnew
                Inew(i,j)=4*A(i,j)+1;
            end
        end
        
        for i=1:nnew
            for j=nnew+1:N
                Inew(i,j)=4*A(i,j-nnew)+2;
            end
        end
        
        for i=nnew+1:N
            for j=1:nnew
                Inew(i,j)=4*A(i-nnew,j)+3;
            end
        end
        
        for i=nnew+1:N
            for j=nnew+1:N
                Inew(i,j)=4*A(i-nnew,j-nnew);
            end
        end    
          
    end
    
end

