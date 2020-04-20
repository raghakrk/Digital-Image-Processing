function G = readraw(filename,X,Y)
% X is height Y is width
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
	[N1 N2]=size(pixel);
%     Y=481;X=321;
	Size=(Y*X);
	% Construct matrix
	G = zeros(Y,X);


	% Write pixels into matrix
	
    G(1:Size) = pixel(1:N1);
 
        
	% Transpose matrix, to orient it properly
    G=G';
end %function