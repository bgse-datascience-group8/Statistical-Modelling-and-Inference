# Generalized Linear Models

__Generative models__: generate data, generate t's according to model then x given t. This might make sense in the contex of an election where m is enormous but n is very small. Very few replications (polls x determine elections t) QUESTION: How is this different?
__Discriminative models__: More sensical if modeling outcome because why model all the x dimensions

Moments and convexity

Save memory by storing dimension instead of actual data

Exponential family and sufficient statistics

Hospital example of varied weights given to hospitals with greater number of observations

First derivative of theta mle is a weited sum of observations

Sometimes makes no sense to say $g(y(x_{n},w)) = \phi(x_{n})^{T}w$, for example when y must fall in some range. g maps into the real line whatever y lives. Transormation of your mean from -inf to inf, to make a linear transformation in w possible.

Example of g may be log function of (y / y - 1)
