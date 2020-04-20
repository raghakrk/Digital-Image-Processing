function error_difussion_color(filename, height,width)

[IR,IG,IB]=readraw_rgb(filename,height,width);
img(:,:,1)=IR;img(:,:,2)=IG;img(:,:,3)=IB;

IC=color_comp(IR);
IM=color_comp(IG);
IY=color_comp(IB);
imgc(:,:,1)=IC;imgc(:,:,2)=IM;imgc(:,:,3)=IY;

ICo=errdif(IC);
IMo=errdif(IM);
IYo=errdif(IY);

IRco=color_comp(ICo);
IGco=color_comp(IMo);
IBco=color_comp(IYo);
imgocr(:,:,1)=IRco;imgocr(:,:,2)=IGco;imgocr(:,:,3)=IBco;

figure;
imshow(uint8(imgocr));
% imsave
end