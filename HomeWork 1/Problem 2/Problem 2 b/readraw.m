function [R,G,B] = readraw(filename)
%readraw - read RAW format grey scale image of square size into matrix G
% Usage:	G = readraw(filename)

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
	[Y X]=size(pixel);
	Size=(Y*X/3);
	N=sqrt(Size);
	% Construct matrix
	R = zeros(N,N);
    G = zeros(N,N);
    B = zeros(N,N);

	% Write pixels into matrix
	
    R(1:Size) = pixel(1:3:Y);
    G(1:Size) = pixel(2:3:Y);
    B(1:Size) = pixel(3:3:Y);
        
	% Transpose matrix, to orient it properly
    R=R';G=G';B=B';
end %function
