function possibilities = classify(ovDistances,thresholds)
% function possibilities = Classify(ovDistances,thresholds)
%
% -------------------------------------------------------------------------
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
% classify analyzes the overall distances between the actual window and all
% of the models to determine the possibility of each model to represent the
% actual acceleration data.

% COMPUTE THE POSSIBILITY OF EACH MODEL
% (mapping of the likelihoods from [0..threshold(i)] to [1..0]
numModels = length(thresholds);
possibilities = zeros(numModels,1);
for i=1:1:numModels
    possibilities(i) = 1 - ovDistances(i)/thresholds(i);
    if (possibilities(i) < 0)
        possibilities(i) = 0;
    end
end