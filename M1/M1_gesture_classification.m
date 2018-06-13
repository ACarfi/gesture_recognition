function [possibilities] = M1_gesture_classification(models, possibilities, gravity, body)
% Author: Barbara Bruno (dept. DIBRIS, University of Genova, ITALY)
%         Alessandro Carfì (dept. DIBRIS, University of Genova, ITALY)
%
% This code is the implementation of the architecture described in the
% paper "Using fuzzy logic to enhance classification of human motion 
% primitives".
%
% I would be grateful if you refer to the paper in any academic
% publication that uses this code or part of it.
% Here is the BibTeX reference:
%
% @inproceedings{bruno2014using,
%    title={Using fuzzy logic to enhance classification of human motion primitives},
%	 author={Bruno, Barbara and Mastrogiovanni, Fulvio and Saffiotti, Alessandro and Sgorbissa, Antonio},
%	 booktitle={Proceeding of the 2014 International Conference on Information Processing and Management of Uncertainty in Knowledge-Based Systems (IPMU 2014)},
%	 pages={596--605},
%	 year={2014},
%	 month={July},
%    address={Montpellier, France}
% }
%
%--------------------------------------------------------------------------
%
% M1_gesture_classification receives at each new sample the data contained 
% on the moving horizon window divided in gravity and body, the precedent 
% probabilities and the GMM models. The models are compared with the
% current data in order to generate the gesture probabilities and the 
% probabilities vector is updated

    numModels = length(models);
    models_size = zeros(1,numModels);
    
    for m=1:1:numModels
        models_size(m) = size(models(m).bP,2);
    end
    
    thresholds = zeros(1,numModels);
    for m=1:1:numModels
        thresholds(m) = models(m).threshold;
    end

    for m=1:1:numModels
        dist(m) = compare_with_models(gravity(1:models_size(m),:),body(1:models_size(m),:),models(m).gP,models(m).gS,models(m).bP,models(m).bS);
    end
    possibilities = [possibilities; classify(dist,thresholds)'];
end

