function [label, possibilities, max_possibilities] = M1_gesture_recognition(input, window_size, possibilities, tau, gamma, max_possibilities)
% Author: Alessandro Carfì (dept. DIBRIS, University of Genova, ITALY)
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
% M1_gesture_recognition receives at each new sample the data contained 
% on the moving average window. It loads the GMM and GMR models and calls 
% the funtions:
%
% - window_filtering
% - M1_gesture_classification
% - M1_gesture_detection
%
% The label returned by this procedure is modified to match the correct
% naming and is returned to the main script.

    load('GMM_GMR_models');
          
    %% Gravity Filtering
    [gravity, body] = window_filtering(input, window_size);
    
    %% Gesture Classification
    [possibilities] = M1_gesture_classification(models, possibilities, gravity, body);
    
    %% Gesture Detection
    [label, max_possibilities] = M1_gesture_detection(max_possibilities,possibilities, tau, gamma);
    
    %% Arrange Naming Space
    if label == 3
        label = 5;
    elseif label == 4
        label = 6;
    elseif label == 5
        label = 3;
    elseif label == 6
        label = 4;
    end
end

