## Notes from Chapter 1 Bishop / Pattern Recognition and Machine Learning

### Terms

* **Generalization:** The ability to categorize correctly new data points into a categorization algorithm. Example: Extracting numerical values from images of handwritten numbers.
* **Feature extraction:** Preprocessing done on the data to extract processable data for an algorithm
* **Reinforcement Learning:** An algorithm tasked with finding the best actions to take to maximize (or minimize?) an outcome. Example: teaching a neural network to play (and win) backgammon.
* **Credit assignment:** Typically referenced as a credit assignment problem where when trying to assess a output variable through many input variables where it is indeterminate what drove the outcome and some inputs may be inaccurately classified. 

### Section 1.1: Example: Polynomial Curve Fitting

In this section, Bishop gives the example of fitting a training set of data generated from the function sin(2(pi)x) plus some randomly generated error. The objective is to determine this underlying algorithm but of course that is intrinisically difficult as we have to generalize from a finite data set (pg 5).

Because we cannot know sin(2(pi)x), we try and fit the data using an j-order polynomial with j number of coefficients. The values for the coefficient(s) will be estimated using the training data by minimizing the error function which, in this example, is the function of the distance between the observed and estimated value of the function of x for the model. These coefficients compose the vector w of j components. 

#### Terms

* **Regularization:** Adding a penalty term to the error term to avoid the coefficients reaching large values
