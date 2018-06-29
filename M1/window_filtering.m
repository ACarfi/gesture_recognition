function [gravity, body] = window_filtering(window,window_size)
% Author: Barbara Bruno (dept. DIBRIS, University of Genova, ITALY)
%       : Carola Motolese (dept. DIBRIS, University of Genova, ITALY)
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
% -------------------------------------------------------------------------
%
% window_filtering separates the gravity and body acceleration features
% contained in the [window] of acceleration data, by first reducing
% the noise on the raw data with a median filter and then discriminating
% between the features with a low-pass IIR filter.
%

% REDUCE THE NOISE ON THE SIGNALS BY MEDIAN FILTERING
n = 3;      % order of the median filter
clean_window(:,:) = medfilt1(window(:,:),n);

% SEPARATE THE GRAVITY AND BODY-ACCELERATION COMPONENTS
% Type II Chebyshev filter parameters (all frequencies are in Hz)
Fs = 10;            % sampling frequency Fs = 10;
Fpass = 0.25;       % passband frequency Fpass = 0.25; 
Fstop = 0.4;        % stopband frequency Fstop = 2;
Apass = 0.1;        % passband ripple (dB) Apass = 0.001;
Astop = 60;         % stopband attenuation (dB) Astop = 100;
match = 'pass';     % band to match exactly match = 'pass';
delay = 40;         % delay (# samples) introduced by filtering  delay = 1;%
% create the Type II Chebyshev filter
h  = fdesign.lowpass(Fpass, Fstop, Apass, Astop, Fs);
Hd = cheby2(h,'MatchExactly', match);

% apply the filter on the acceleration signals (to isolate gravity)
g(:,1) = filter(Hd,clean_window(:,1));
g(:,2) = filter(Hd,clean_window(:,2));
g(:,3) = filter(Hd,clean_window(:,3));
% compute the body-acceleration components by subtraction
g = circshift(g,[-delay 0]);
i = 1:1:(window_size-delay);
gravity(i,:) = g(i,:);
body(i,:) = clean_window(i,:) - gravity(i,:);