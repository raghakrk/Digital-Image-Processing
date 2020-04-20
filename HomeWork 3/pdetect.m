function hit=pdetect(Ii)
M=[0 0 0;0 1 0;0 0 0];
hit=0;
Im=Ii;
[R,C]=size(Im);
    for i=2:R-1
        for j=2:C-1
            if (Im(i-1,j-1)==M(1,1)) && (Im(i-1,j)==M(1,2)) && (Im(i-1,j+1)==M(1,3))&& (Im(i,j-1)==M(2,1))&&(M(2,2)==Im(i,j))&& (M(2,3)==Im(i,j+1))&& (M(3,1)==Im(i+1,j-1)) && (M(3,2)==Im(i+1,j)) && (M(3,3)==Im(i+1,j+1))
                Im(i,j)=1;
                hit=hit+1;
                L(hit,1)=i;
                L(hit,2)=j;          
            end              
        end
    end
end
