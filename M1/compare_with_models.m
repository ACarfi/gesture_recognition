function ovDistance = compare_with_models(gravity,body,MODELgP,MODELgS,MODELbP,MODELbS)

% Author: Barbara Bruno (dept. DIBRIS, University of Genova, ITALY)
%
% This code is the implementation of the architecture described in the
% paper "Using fuzzy logic to enhance classification of human motion 
% primitives".
%
% I would be grateful if you refer to the paper in any academic
% publication that uses this code or part of it.
% Here is the BibTeX reference:
% @inproceedings{bruno2014using,
%    title={Using fuzzy logic to enhance classification of human motion primitives},
%	 author={Bruno, Barbara and Mastrogiovanni, Fulvio and Saffiotti, Alessandro and Sgorbissa, Antonio},
%	 booktitle={Proceeding of the 2014 International Conference on Information Processing and Management of Uncertainty in Knowledge-Based Systems (IPMU 2014)},
%	 pages={596--605},
%	 year={2014},
%	 month={July},
%    address={Montpellier, France}
% }
% -------------------------------------------------------------------------
%
% compare_with_models computes Mahalanobis distance between the features
% [gravity] and [body] of the actual window and one model of HMP.

% COMPUTE MAHALANOBIS DISTANCE BETWEEN MODEL FEATURES AND WINDOW FEATURES
numPoints = size(MODELgS,3);
gravity = gravity';
body = body';
time = MODELgP(1,:);
distance = zeros(numPoints,2);
for i=1:1:numPoints
    x = time(i);
    distance(i,1) = (transpose(gravity(:,x)-MODELgP(2:4,time==x)))*inv(MODELgS(:,:,time==x))*(gravity(:,i)-MODELgP(2:4,time==x));
    distance(i,2) = (transpose(body(:,x)-MODELbP(2:4,time==x)))*inv(MODELbS(:,:,time==x))*(body(:,i)-MODELbP(2:4,time==x));
end
% compute the overall distance as the mean of the features distances
ovDistance = mean(mean(distance));