# Bayesian Regression


Measuring the joint probability of t, X, w, q using the probability (likelihood) of t given X, w, q times the probabilty of X (which is assumed as independent of w and q) and the prior probability of p(w, q).

**Question:** What does it mean the prior is the probability of p(w, q)?

The posterior is given as the probability of w and q given t and X (**Question:** How is X different from t?)

Slide 8 of bayesian-regression
**Questions:**

1. Why is the probability of w equal to the normal distribution of w given mu and D?
2. Why are mu and D fixed? (Isn't this by definition?)
3. p(x(1:n)) is irrelevant because? They are used to derive features and then disposed?

## Notes from Bishop Chapter 2

**Question:** Where is the difference in figure 2.28???

## Notes from Bishop Chapter 3

Linear regression is linear in the parameter vector w but not necessarily linear in the functions of x (p139). These functions of x are termed the **bases functions** and the most typical example would be the polynomial bases functions.

**Spline** functions describe the objective of dividing the input space into different regions, each having its own basis function of a different order polynomial.

Gaussian basis functions are also used and it is noted that the normalization coefficient is unimportant because the linear model uses adaptive w coefficients.

**Section 3.2: The Bias-Variance Decomposition**

**Question:** What is the intution behind the regularization coefficient $\lambda$?

**Question (general):** Clarification of "prior" vs "posterior" probability.

* *Prior* probability is given by the probability conditioned upon one's prior beliefs before any evidence is taken into account.
* 

The two ways to measure uncertainty (p148):

1. **Bayesian:** The Bayesian capture of the uncertainty of in our model is to quantify it through a distribution over w after it is modeled (the posterior?)

2. **Frequentist:** Given N data sets from the same distribution, when a model is formed using one data set its uncerainty is measured in its accuracy in its prediction compared with the other data sets.


**Question:** (equation 3.48) Where do the mu0 and S0 come from?

> Maximization of this posterior distribution wrt w is equivalent to minimizing the sum of squares error function with the addition of a regularization term, lambda which is alpha / beta. (p153)

**PAGE 153 - 156 PROVIDE AN AMAZING SIMPLE EXAMPLE OF BAYESIAN LINEAR REGRESSION LEARNING**

**Question:** Figure 3.9 page 158 is visually represents how with one data point, our estimates for w are completely random (e.g. any value of w has 0 probability since w is a continuous random variable)

