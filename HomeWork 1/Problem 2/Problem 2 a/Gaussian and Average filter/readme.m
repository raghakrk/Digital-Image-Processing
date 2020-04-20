% EE569 Homework Assignment #1
% Date: January 22, 2019
% Name: Raghak Radhakrishnan
% ID: 3972-8313-70
% email: raghakra@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 2 A: Gray level image Denoising 
% Implementation 2: Gaussian and Uniform weighted filter
% Main M-file name: main_gauss.m

% Function M-files: readraw.m 
% Implementation: Read raw file
% Parameters: [filename]

% Function M-files: writeraw.m
% Implementation: Write raw file
% Parameters: [filename]

% Function M-files: refl_img.m
% Implementation: Boundary mirror function
% Parameters: [image array of MxN; window size]

% Function M-files: mask_conv.m
% Implementation: Implementing convolution of kernel
% Parameters: [image array of MxN; kernel window size; kernel]
% output: Convoluted image

% Function M-files: returnPSNR.m
% Implementation: Calculate PSNR
% Parameters: [image array of MxN; kernel window size; kernel]
% Output: PSNR

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%