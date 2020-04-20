function [R,G,B] = readraw_rgb(filename,X,Y)
%readraw - read RAW format grey scale image of square size into matrix G
% Usage:	G = readraw(filename)
%     Y=500;X=375;
	disp(['	Retrieving Image ' filename ' ...']);

	% Get file ID for file
	fid=fopen(filename,'rb');

	% Check if file exists
	if (fid == -1)
	  	error('can not open input image file press CTRL-C to exit \n');
	  	pause
	end

	% Get all the pixels from the image
	pixel = fread(fid, inf, 'uchar');

	% Close file
	fclose(fid);

	% Calculate length/width, assuming image is square
	[N1 N2]=size(pixel);

	Size=(Y*X);
	% Construct matrix
	R = zeros(Y,X);
    G = zeros(Y,X);
    B = zeros(Y,X);

	% Write pixels into matrix
	
    R(1:Size) = pixel(1:3:N1);
    G(1:Size) = pixel(2:3:N1);
    B(1:Size) = pixel(3:3:N1);
        
	% Transpose matrix, to orient it properly
    R=R';G=G';B=B';
end %function