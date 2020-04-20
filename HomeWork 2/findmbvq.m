function x=findmbvq(r,g,b) 
    r=r*255;
    g=g*255;
    b=b*255;
%         
     if ((r+g)>255)
        if ((g+b)>255)
            if ((r+g+b)>510)
                x=1;                
            else 
                x=2;  
            end
        else
            x=3;  
        end
     else
         if ((g+b)<255)
             if((r+g+b)<255)
                 x=4;
             else
                 x=5;
             end
         else
             x=6;
         end
     end
end

