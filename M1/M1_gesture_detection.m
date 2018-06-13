function [label,max_possibilities] = M1_gesture_detection(max_possibilities,possibilities, tau, gamma)
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
% M1_gesture_detection receives at each new sample the probabilities
% vector, the two thresholds and the maximum probability value for each
% gesture. If the peak-fall pattern is detected the corresponding label is
% returned to the main script.

    max_possibilities(find(possibilities(end,:) > max_possibilities)) = possibilities(end,(find(possibilities(end,:) > max_possibilities)));
    diff = max_possibilities - possibilities(end,:);
    
    possible = find(diff > max_possibilities*gamma);
    
    label = NaN;
    
    if not(isempty(possible))
        gestures(possible(find(max_possibilities(possible) > tau))) = 1;
        max_possibilities(possible(find(max_possibilities(possible) > tau))) = -inf;
        max_possibilities(possible(find(max_possibilities(possible) > tau))) = 0;
        
        if ~isempty(find(gestures))
            label = find(gestures);
        end            
    end
end

