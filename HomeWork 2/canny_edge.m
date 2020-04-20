function canny_edge(filename, height,width,T)
[PR,PG,PB]=readraw_rgb(filename, height,width);
[X,Y]=size(PR);
for i=1:X
    for j=1:Y
        P(i,j)=0.299 * PR(i,j) + 0.587 * PG(i,j) + 0.114 * PB(i,j);
    end
end
CP=edge(P,'canny',[0.4*T T]);
imshow(uint8(255*(1-CP)));
writeraw(CP,'canny_out.raw');
% figure;
% j=1;
% for i=0.15:0.05:0.3
%     CP=edge(P,'canny',[ 0.4*i i]);
%     subplot(2,2,j);
%     imshow(uint8(255*(1-CP)));
%     title([num2str(j) '. Canny edge for high threshold ' num2str(i) ' and low threshold ' num2str(0.4*i)])
%     j=j+1;
% end
% imshow(uint8(255*(1-CT)));
% th=0.25;
% figure;
% for i=1:4
%     CT=edge(P,'canny',[ 0.4*th th],i);
%     subplot(2,2,i);
%     imshow(uint8(255*(1-CT)));
%     title(['Canny edge for high threshold ' num2str(th) ' and low threshold ' num2str(0.4*th) ' and sigma ' num2str(i)])
% end
% % imshow(uint8(255*CP));
% 
end