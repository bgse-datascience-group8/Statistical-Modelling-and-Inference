# Bayesian Prediction

**Qinv:** How far away is your predective input from your training input?

#### Bayes "Local averaging"

When doing predictive distribution when calculating the mean

k measures simlarity between inputs, features from x and y and looking at them by linear form for a particular precision matrix to define function k when you're predicting the mean, the conditional expectation given the input at that location and the training data it turns out to be the sum over the k function of all training data * t:

Sum(k(xn, xn+1)*tn)

Going to predict, for some input, the output, based on a local weight from the known outputs, the local outputs have more weight than outputs far away.

Choosing the features is really ipmotant to determining the metric "close" to "far away"

Realize that this is very similar to the leverage.

