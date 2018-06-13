function [prec_probabilities] = SLOTH_gesture_classification(input,prec_probabilities,net,window_size)
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
% SLOTH_gesture_classification receives at each new sample the data contained 
% on the moving horizon window, the precedent probabilities, the network 
% and the window length. It uses the network to compute gesture
% probabilities for the current window and updates the probabilities vector

    probabilities = predict(net,input,'MiniBatchSize',window_size,'ExecutionEnvironment','cpu');
    prec_probabilities = [prec_probabilities, probabilities'];
end

