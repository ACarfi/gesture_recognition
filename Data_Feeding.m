% Author: Alessandro Carfì (dept. DIBRIS, University of Genova, ITALY)
%
% This code is the implementation of the architecture described in the
% paper "Human Gesture Continuous Recognition: A Comparison Study".
%
% -------------------------------------------------------------------------
%
% Data_feeding loads a sequence of linear acceleration data containing n 
% gestures from the "./data" folder and feeds the data, according to the
% moving window techinque, to two methods for the continuous gesture 
% recognition:
%
% - SLOTH: presented in the paper "Online Human Gesture Recognition using 
%          Recurrent Neural Networks and Wearable Sensors".
% 
% - M1: presented in the paper "Using fuzzy logic to enhance classification
%       of human motion primitives".
%
%
% The output of the two methods is displayed on two plot together with  the
% raw acceleration data.


addpath('./M1')
addpath('./SLOTH')

path = './data/121234345656.txt';

%Data Frequency (Hz)
F_Data = 40;

%Data Frequency required for each method (Hz)
F_Sloth = 10;
F_M1 = 40;

Dictionary_Size = 6;

%Window dimension for each method (samples)
Window_Sloth = 40;
Window_M1 = 95;

%%SLOTH Parameters
C = [3.9 3.9 3.85 3.85 3.9 3.9];
Tau = [0.896 0.896 0.873 0.895 0.84 0.825];

%%M1 Parameters
tau = 0.5;
gamma = 0.8;

Data = load(path);

%%Rearrange sampling frequency
Input_Sloth = Data(1:F_Data/F_Sloth:size(Data,1),:)'; 
Input_M1 = Data(1:F_Data/F_M1:size(Data,1),:); 


%% Feeding SLOTH method

probabilities = zeros(Dictionary_Size,Window_Sloth);

Sloth_Labels = zeros(1,length(Input_Sloth));
Sloth_Labels(:) = NaN;

peaks = zeros(1,Dictionary_Size);

for i=Window_Sloth:length(Input_Sloth)
    [Sloth_Labels(i), probabilities, peaks] = SLOTH_gesture_recognition(Input_Sloth(:,i-Window_Sloth+1:i), Window_Sloth, probabilities, peaks, C, Tau);
end

%% Feeding M1

possibilities = zeros(Window_M1, Dictionary_Size);
possibilities(:,:) = NaN;

M1_Labels = zeros(length(Input_M1));
M1_Labels(:) = NaN;

max_possibilities = zeros(1,6);
max_possibilities(:) = -inf;
    
for i=Window_M1:length(Input_M1)
    [M1_Labels(i), possibilities, max_possibilities] = M1_gesture_recognition(Input_M1(i-Window_M1+1:i,:),Window_M1,possibilities, tau, gamma, max_possibilities);
end

%% Plotting Sloth

time = 0:1/F_Sloth:(length(Input_Sloth)-1)/F_Sloth;

time_gestures = find(~isnan(Sloth_Labels))/F_Sloth;
gestures = Sloth_Labels(find(~isnan(Sloth_Labels)));

figure

subplot(3,1,1)
title('Sequence: 121234345656, Recognizer: SLOTH')
hold on
plot(time, Input_Sloth(1,:),'r')
for i=1:length(gestures)
   textG = strcat('G',num2str(gestures(i)));
   text(time_gestures(i),5,textG,'HorizontalAlignment','right')
end
xlabel('time (s)') 
ylabel('acc (m/s^2)')

subplot(3,1,2)
hold on
plot(time, Input_Sloth(2,:),'g')
for i=1:length(gestures)
   textG = strcat('G',num2str(gestures(i)));
   text(time_gestures(i),5,textG,'HorizontalAlignment','right')
end
xlabel('time (s)') 
ylabel('acc (m/s^2)')

subplot(3,1,3)
hold on
plot(time, Input_Sloth(3,:),'b')
for i=1:length(gestures)
   textG = strcat('G',num2str(gestures(i)));
   text(time_gestures(i),5,textG,'HorizontalAlignment','right')
end
xlabel('time (s)') 
ylabel('acc (m/s^2)')

%% Plotting M1

time = 0:1/F_M1:(length(Input_M1)-1)/F_M1;

time_gestures = find(~isnan(M1_Labels))/F_M1;
gestures = M1_Labels(find(~isnan(M1_Labels)));

figure

subplot(3,1,1)
title('Sequence: 121234345656 - Recognizer: M1')
hold on
plot(time, Input_M1(:,1),'r')
for i=1:length(gestures)
   textG = strcat('G',num2str(gestures(i)));
   text(time_gestures(i),5,textG,'HorizontalAlignment','right')
end
xlabel('time (s)') 
ylabel('acc (m/s^2)')

subplot(3,1,2)
hold on
plot(time, Input_M1(:,2),'g')
for i=1:length(gestures)
   textG = strcat('G',num2str(gestures(i)));
   text(time_gestures(i),5,textG,'HorizontalAlignment','right')
end
xlabel('time (s)') 
ylabel('acc (m/s^2)')

subplot(3,1,3)
hold on
plot(time, Input_M1(:,3),'b')
for i=1:length(gestures)
   textG = strcat('G',num2str(gestures(i)));
   text(time_gestures(i),5,textG,'HorizontalAlignment','right')
end
xlabel('time (s)') 
ylabel('acc (m/s^2)')