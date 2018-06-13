function [label, peaks, l] = SLOTH_gesture_detection(label_prob, label, peaks, threshold, win, puntual_classification)
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
    if isempty(find(isnan(label_prob(:,time-1:time))))
        derivative = diff(label_prob(:,time-1:time),1,2);
    
        for i=1:length(peaks)
            if derivative(i) > 0.2
                temp = peaks{i};
                if isempty(temp)
                    time_diff = win(i);
                else
                    time_diff = time - temp(end);
                end
                
                if time_diff >= win(i)
                   peaks{i} = [temp, time];
                end
            end

            temp = peaks{i};
            L = NaN;
            
            if not(isempty(temp))
                if (time-temp(end)+1) >= win(i)
                    if mean(label_prob(i,temp(end):time)) > threshold(i)
                        L = time;
                        if puntual_classification
                            peaks{i} = [];
                        end
                    end
                end
            end
            
            label{i} = [label{i}, L];
       end
    end
   
    temp = [];
    for i=1:length(label)
        temp = [temp, label{i}(end)];
    end

    if isempty(find(~isnan(temp)))
        l = NaN;
    else
        l = find(~isnan(temp));
    end
end

