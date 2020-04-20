function [tp,tn,fp,fn]=TFPN(It,map)
        [X,Y]=size(map);
        tp=0;fp=0;fn=0;tn=0;
        for i=1:X
            for j=1:Y
                if (It(i,j)==1 && map(i,j)==1)
                    tp=tp+1;
                elseif(It(i,j)==0 && map(i,j)==1)
                    fp=fp+1;
                elseif(It(i,j)==1 && map(i,j)==0)
                    fn=fn+1;
                elseif(It(i,j)==0 && map(i,j)==0)
                    tn=tn+1;    
                end
            end
        end
end