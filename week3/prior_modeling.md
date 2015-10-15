# Prior Modeling

Making the assumption w's are aprior independent (*prior independence*).

Posterior is not having the same assumption.

For example, categorial data, multinomial data with three categories, {A, B, C} ("three word dictionary"), having a multinomial distribution.

Apriori assumption about independence is obviously inaccurate as their probabilities must sum up to 1. "Each one is perfectly correlated with the other 2". You have to think of a model for all three of them.

One way to do it is the Dirichlect distribution. It's a distribution of dependent variables, each between [0,1] summing up to 1.

We have been working under the assumption w ~ N(0, (delta)-1*I). But this may not make any sense whatsoever.

Example: Real-estate distance to covenience store in meters and distance to airport in km, the coefficient for distance to convenience store we would expect to be much larger.

*Note on inputs vs features*

Features may have been standardized (should have been standardized)

wj * xj = wj * sd(xj) * phij

The assumption of same variance makes sense (identically distributed, may be not independent).
Assuming homogeneity is very hard.

## Re-thinking our Bayes regression

Instead of making the assumption about the p(X) being independent of the distribution of w and q, we can make the prior p(w,q | X)

Let the prior depend on the sd of the input.

Prior and posterior density are called a conjugate pair. Prior is a density you can parameterize, when you multiple the prior by the likelihood.

Posterior is informed by the prior and the likelihood. Theta --> Theta' (*Update your beliefs.*)

Conjugate pairs of distributions are really convenient for carrying out computations really fast because of mathematical tractability.

If you know about the distribute you can know about marginal distributions and conditional distributions. Makes the bayesian learning really really fast.

*Tangent: Everyone thinks of bernoulli as two outcomes 0 and 1 but its really two probabilities summing up to one.*

Prior of bernoulli distribution is that p1 has a beta distribution [0,1], and p2 having also a beta distribution 1 - p1

Generalization to k-probabilities (Multinomial) has a Dirichlect distribution alpha1 to alphak.

Common pair: linear model and gaussian.

**Main principle for choosing priors in a Baysian Model: "Kick the can down the road"**

Assume w ~ N(0, delta^-1)

This delta is also an unknown so we should use a prior for it as well.

Example: Fixing the prior to be 1 (when the true value is 10) and fixing the mean of the distribution of the prior to be 1. Now there is some probability we can discover the true value.

**Question: In practice, would you ever prescribe a prior without observing some data? In practice do you ever go below lambda?**

### Prior Ignorance

I would like to choose priors that if I have a lot of data, the prior means less and I can recover the truth. Doesn't really extend to a large number of parameters.

Flat prior: posterior is just dependent on MLE. BUT this doesn't integrate to one - an **improper prior**. BUT there is no reason why the likelihood should integrate to 1.

"When you go down this road you start the monkey business."

If you choose a prior which is not integrable, the posterior also may not be integrable.

Possible when phi t(phi) is invertible (posterior is not well-defined).




