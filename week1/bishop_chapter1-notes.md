## Notes from Chapter 1 Bishop / Pattern Recognition and Machine Learning

### Terms

* **Generalization:** The ability to categorize correctly new data points into a categorization algorithm. Example: Extracting numerical values from images of handwritten numbers.
* **Feature extraction:** Preprocessing done on the data to extract processable data for an algorithm
* **Reinforcement Learning:** An algorithm tasked with finding the best actions to take to maximize (or minimize?) an outcome. Example: teaching a neural network to play (and win) backgammon.
* **Credit assignment:** Typically referenced as a credit assignment problem where when trying to assess a output variable through many input variables where it is indeterminate what drove the outcome and some inputs may be inaccurately classified. 



### 1.1: Example: Polynomial Curve Fitting

In this section, Bishop gives the example of fitting a training set of data generated from the function sin(2(pi)x) plus some randomly generated error. The objective is to determine this underlying algorithm but of course that is intrinisically difficult as we have to generalize from a finite data set (pg 5).

Because we cannot know sin(2(pi)x), we try and fit the data using an j-order polynomial with j number of coefficients. The values for the coefficient(s) will be estimated using the training data by minimizing the error function which, in this example, is the function of the distance between the observed and estimated value of the function of x for the model. These coefficients compose the vector w of j components. 

#### Terms

* **Regularization:** Adding a penalty term to the error term to avoid the coefficients reaching large values



### 1.2: Probability Theory

1.2.1 Probability Densities

Random, repeatable events define the assumptions made by the *classical or frequentist view.*

1.2.2 Expectations and Covariances

Expected value is a weighted average of the possible outcomes.

If x and y are independent the covariance approaches 0.

1.2.3 Bayesian probabilities

Define probabilities in the context of a quantification of uncertainty (39).

The likelihood function describes how probable is a set of data is for a given value of w (the parameter vector): p(D|w) (40).

The likelihood function in the frequentist view estimates w as a fixed value and then gives the probability function of D for the given w. The Bayesian view of the likelihood function is given a set of D and can state the probability density of w to express the uncertainty of those parameters.

#### Terms

* **Maximum Likelihood:** The maximum likelihood maximizes the likelihood function, determining the parameters (w) for which the probability of the observed data (D) is maximized. The negative log of likelihood is called the error function, which expresses the best fit for the data which minimizes the error. Maximizing the likelihood is equivalent to minimizing the error.

* **Bootstap:** Quantifies the statistical accuracy of the parameters by creating, from the original data set X, variations in X using random sampling, so that these variations contain some of the original values. Statistical accuracy is determined by looking at the variabiltiy of predictions from the bootsrapped sets.

