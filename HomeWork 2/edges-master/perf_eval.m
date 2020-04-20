function [thrs,cntR,sumR,cntP,sumP,R,P] = perf_eval( E, G, varargin )
% Calculate edge precision/recall results for single edge image.
%
% Enhanced replacement for evaluation_bdry_image() from BSDS500 code:
%  http://www.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/
% Uses same format and is fully compatible with evaluation_bdry_image.
% Given default prms results are *identical* to evaluation_bdry_image.
%
% In addition to performing the evaluation, this function can optionally
% create a visualization of the matches and errors for a given edge result.
% The visualization of edge matches V has the following color coding:
%  green=true positive, blue=false positive, red=false negative
% If multiple ground truth labels are given the false negatives have
% varying strength (and true positives can match *any* ground truth).
%
% This function calls the mex file correspondPixels. Pre-compiled binaries
% for some systems are provided in /private, source for correspondPixels is
% available as part of the BSDS500 dataset (see link above). Note:
% correspondPixels is computationally expensive and very slow in practice.
%
% USAGE
%  [thrs,cntR,sumR,cntP,sumP,V] = edgesEvalImg( E, G, [prms] )
%
% INPUTS
%  E          - [h x w] edge probability map (may be a filename)
%  G          - file containing a cell of ground truth boundaries
%  prms       - parameters (struct or name/value pairs)
%   .out        - [''] optional output file for writing results
%   .thrs       - [99] number or vector of thresholds for evaluation
%   .maxDist    - [.0075] maximum tolerance for edge match
%   .thin       - [1] if true thin boundary maps
%
% OUTPUTS
%  thrs       - [Kx1] vector of threshold values
%  cntR,sumR  - [Kx1] ratios give recall per threshold
%  cntP,sumP  - [Kx1] ratios give precision per threshold
%  V          - [hxwx3xK] visualization of edge matches
%
% EXAMPLE
%
% See also edgesEvalDir
%
% Structured Edge Detection Toolbox      Version 3.01
% Code written by Piotr Dollar, 2014.
% Licensed under the MSR-LA Full Rights License [see license.txt]

% get additional parameters


dfs={ 'out','', 'thrs',20, 'maxDist',.0075, 'thin',1 };
[out,thrs,maxDist,thin] = getPrmDflt(varargin,dfs,1);
if(any(mod(thrs,1)>0)), K=length(thrs); thrs=thrs(:); else
  K=thrs; thrs=linspace(1/(K+1),1-1/(K+1),K)'; end

% load edges (E) and ground truth (G)
if(all(ischar(E))), E=double(imread(E))/255; end
G=load(G); G=G.groundTruth; n=length(G);Rsum=zeros(1,n);
for g=1:n, G{g}=double(G{g}.Boundaries);
Rsum(g)=sum(sum(G{g}));
end

% evaluate edge result at each threshold
Z=zeros(K,1); cntR=Z; sumR=Z; cntP=Z; sumP=Z;
R=zeros(K,n);P=zeros(K,n);

for k = 1:K
  % threshhold and thin E
%   if name=='Sobel'
%    E1=edge(E,'Sobel',k); 
%   elseif name=='Canny'
%       E1=edge(E,'Canny',k);
%   else
%       E1=double(E>=max(eps,thrs(k)));       
% end
  E1 = double(E>=max(eps,thrs(k)));
  if(thin), E1=double(bwmorph(E1,'thin',inf)); end
  % compare to each ground truth in turn and accumualte
  Z=zeros(size(E)); matchE=Z; matchG=Z; allG=Z;
  for g = 1:n
    tempE=zeros(size(E));tempG=zeros(size(E));
    [matchE1,matchG1] = correspondPixels(E1,G{g},maxDist);
    matchE = matchE | matchE1>0;
    matchG = matchG + double(matchG1>0);
    tempE=tempE|matchE1>0;%matchE
    tempG=double(matchG1>0);%matchG
    allG = allG + G{g};
%     Rcnt(k,g)=sum(tempG(:));
%     Pcnt(k,g) = nnz(tempE); 
    Fp=sum(sum(E1-tempE));
    Fn=sum(sum(G{g}-tempG));
    Tp=nnz(tempE);
    R(k,g)=Tp/(Tp+Fn);
    P(k,g)=Tp/(Tp+Fp);
  end
  % compute recall (summed over each gt image)
  cntR(k) = sum(matchG(:)); sumR(k) = sum(allG(:));
  % compute precision (edges can match any gt image)
  cntP(k) = nnz(matchE); sumP(k) = nnz(E1);
  % optinally create visualization of matches
end
