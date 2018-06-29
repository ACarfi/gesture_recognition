function [label, prec_probabilities, peaks_real_time] = SLOTH_gesture_recognition(input, window_size, prec_probabilities, peaks_real_time, C, tau)
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
% SLOTH_gesture_recognition receives at each new sample the data contained 
% on the moving average window. It loads the LSTM neural network
% precedently trained and calls the funtions:
%
% - SLOTH_gesture_classification
% - SLOTH_gesture_detection
%
% The label returned by this procedure is modified to match the correct
% naming and is returned to the main script.

    load('LSTM.mat')  

    %% Gesture Classification
    [prec_probabilities] = SLOTH_gesture_classification(input,prec_probabilities,net,window_size);

    %% Gesture Detection
    [label, peaks_real_time] = SLOTH_gesture_detection(prec_probabilities, peaks_real_time, tau, C);

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

