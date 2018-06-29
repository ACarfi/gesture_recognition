function [label, peaks] = SLOTH_gesture_detection(label_prob, peaks, threshold, win)
% Author: Alessandro Carfì (dept. DIBRIS, University of Genova, ITALY)
%
% This code is the implementation of the algorithms described in the
% paper "Online Human Gesture Recognition using Recurrent Neural Networks
% and Wearable Sensors".
%
% I would be grateful if you refer to the paper in any academic
% publication that uses this code or part of it.
% Here is the BibTeX reference:
%
% @inproceedings{carfi2018online,
%	title={Online Human Gesture Recognition using Recurrent Neural Networks
%	and Wearable Sensors},
%	author={Carf\`i, Alessandro and Motolese, Carola and Bruno Barbara and Mastrogiovanni, Fulvio},
%	booktitle={Proceeding to the 2018 IEEE International Symposium on Robot and Human Interactive Comunication (RO-MAN)},
%	year={2018},
%	moth={August},
%	address={Nanjing and Tai'an, China}
% }
%
%--------------------------------------------------------------------------
%
% SLOTH_gesture_detection receives at each new sample the probabilties
% vector and decide if they represent a gesture occurrence

    time = length(label_prob);
    derivative = diff(label_prob(:,time-1:time),1,2);
    possible_peaks = find(derivative > 0.2,1);
    
    %% Update peaks
    if not(isempty(possible_peaks))
        for i=1:length(possible_peaks) 
            temp = peaks(possible_peaks(i));
            if temp == 0
                peaks(possible_peaks(i)) = time;
            else
                time_diff = time - temp(end);
                if time_diff >= win(i)
                   peaks(possible_peaks(i)) = time;
                end
            end
        end
    end
    
    %% Select active peaks
    active_peaks = find(peaks ~= 0);
    
    %% Check for each active peak if the gesture probabilities satisfy the
    %  detection contraint
    labels = zeros(1,length(peaks));
    labels(:) = NaN;
    
    for i=1:length(active_peaks)
        peak_id = active_peaks(i);
        peak_time = peaks(peak_id);
        
        if (time-peak_time+1) >= win(peak_id)
            if mean(label_prob(peak_id,peak_time:time)) > threshold(peak_id)
                labels(peak_id)  = time;
                peaks(peak_id) = 0;
            end
        end
    end
    
    %Output the label
    if isempty(find(~isnan(labels),1))
        label = NaN;
    else
        label = find(~isnan(labels));
    end
end

