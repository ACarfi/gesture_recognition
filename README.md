## Human Gesture Continuous Recognition: A Comparison Study

This repository contains Matlab codes for the comparison between to methods for continous gesture recognition:

* M1, is a method that models gestures using Gaussian Mixture Models and Gaussian Mixture Regression and performs a probabilistic classification of each gesture using the Mahalanobis distance. A gesture instance is then detected if the associated probability overcomes some thresholds.

* SLOTH, is a method that uses a Long Short Term Memory Recurren Neural Network (LSTM-RNN) as a probabilistic classifier. The probabilities behaviour over time is compared with the expected one to detect gestures.

The "Data_Feeding" module loads the example sequence stored in the data folder, downsamples the data for SLOTH and feeds the two methods according to the sliding window techinque. Results of the gesture recognition process are displayed in one ploth for each method.

[M1](https://link.springer.com/chapter/10.1007/978-3-319-08855-6_60) have been presented in the paper "Using fuzzy logic to enhance classification of human motion primitives". Refer to this pubblication for further informations.

SLOTH have been presented in the paper "Online Human Gesture Recognition Using Recurrent Neural Networks and Wearable Sensors". Refer to this pubblication for further informations.

Results of the comparative study between the two methods have been submitted to the 17th International Conference of the Italian Association for Artificial Intelligence.

## Authors

* Alessandro Carfì, dept. DIBRIS Università degli Studi di Genova (Italy) [alessandro.carfi@dibris.unige.it](alessandro.carfi@dibris.unige.it)
* Carola Motolese, dept. DIBRIS Università degli Studi di Genova (Italy) [carola.motolese@gmail.com](carola.motolese@gmail.com)
* Barbara Bruno, dept. DIBRIS Università degli Studi di Genova (Italy) [barbara.bruno@unige.it](barbara.bruno@unige.it)
* Fulvio Mastrogiovanni, dept. DIBRIS Università degli Studi di Genova (Italy) [fulvio.mastrogiovanni@unige.it](fulvio.mastrogiovanni@unige.it)
