## Human Gesture Continuous Recognition: A Comparison Study

This repository contains Matlab codes for the comparison between to methods for continous gesture recognition:

* M1, is a method that models gestures using Gaussian Mixture Models and Gaussian Mixture Regression and performs a probabilistic classification of each gesture using the Mahalanobis distance. A gesture instance is then detected if the associated probability overcomes some thresholds.

* SLOTH, is a method that uses a Long Short Term Memory Recurren Neural Network (LSTM-RNN) as a probabilistic classifier. The probabilities behaviour over time is compared with the expected one to detect gestures.

The "Data_Feeding" module loads the example sequence stored in the data folder, downsamples the data for SLOTH and feeds the two methods according to the sliding window techinque. Results of the gesture recognition process are displayed in one ploth for each method.
