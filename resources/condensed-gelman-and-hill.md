# Notes from Gelman & Hill

## Chapter 1

**What is multilevel regression?**

The example of regressing student test scores by school. Three options:

* A model where coefficients vary by school ($y = \alpha_{j} + \beta_{j}x + error$)
* A model with more than variance component (??)
* A regression with many predictors including an indicator variable for each school in the data

## Chapter 4

**What is a z-score?** A z-score is an estimation of the coefficients based on a standardized input calculated as the input minus its mean divided by 2 standard deviations.

Two standard deviations are used instead of one for interpretability of binary outputs. If using one standard deviation to calculate the z-score of a coefficient for a binary input, the interpretation would be on the effect of half difference between the two inputs of X. Whe

**What is the difference between the principal components and regression lines?** The principal components line minimizes the euclidian distance where the regression line minimizes the vertical distance.

> However, for the goal of predicting y from x, or for estimating the average of y for any given value of x, the regression line is in fact better—even if it does not appear so at first. (pg 58)

This can be understood by examining the points to the far left: for the PC regression, they are all above the line, whereas in MLE they are split.

**Helps with intuition for _Regression to the Mean_**

## Chapter 18

`lm` function in R computes $\beta^{MLE} = (\textbf{X}^{T} \textbf{X})^{-1} \textbf{X} y$ which results in a best fit (least square of errors) for the parameters.

**Important conclusion: maximizing likelihood of the outputs given the inputs and the parameters is equivalent to minimizing the sum of squares error term**

**Weighted least squares ($\beta^{WLS}$):** Adds a W matrix for weighting each observation as having relatively more or less influence on the optimization:

$$\beta^{WLS} = (\textbf{X}^{T} W \textbf{X})^{-1} \textbf{X}^{T} W y$$

**Bayesian inference in a sentence:** Multiplying a prior distribution reflecting our beliefs by the maximimum likelihood learned from the data forms the posterior distribution, from which random draws reflect both inferences from the data and our beliefs.