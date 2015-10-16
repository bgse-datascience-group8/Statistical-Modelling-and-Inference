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

**Question: In practice, would you ever define a prior without observing some data? In practice do you ever go below lambda?**

### Prior Ignorance

I would like to choose priors that if I have a lot of data, the prior means less and I can recover the truth. Doesn't really extend to a large number of parameters.

Flat prior: posterior is just dependent on MLE. BUT this doesn't integrate to one - an **improper prior**. BUT there is no reason why the likelihood should integrate to 1.

"When you go down this road you start the monkey business."

If you choose a prior which is not integrable, the posterior also may not be integrable.

Possible when phi t(phi) is invertible (posterior is not well-defined).

When you have many w's, it makes sense to simplify your inference to 'push' their value to zero.

Choose priors to shrink the priors to zero. Another way to think of this is the idea of sparsity. I just don't know which factors are important, but I know only a smarll number of them may be relevant.

I expect a covariance matrix to have some zeroes.

Patent the inference about only a certain number of genes having some impact on a given pathology.

### Default Priors for Bayesian Regression

### Conjugate prior for (w, q)

First specifying the marginal of q and then p(q|w). The prior on w given q is Gaussian. Joint distribution of w,q is normal-gamma (w is normal gaussian distributed, q is gamma).

Strange assumption to make this mathematically tractible variance g(qD-1) in normal of p(w|q).

How do you get the posterior out:

* Calculate the K matrix (like the hat matrix) can be computed from the known features (missing a term in the slides)
* Now you can find the posterior distribution of w and q with the bayesian MLE.
* a is just updated (a') with the number of observations
* b (b') is updated with something like the squared residuals: b + (1/2 t^{T} (I - K) t)
* w??
* D

*Note: Q is part of your inference not part of your knowns*

Now it's not a gaussian it's a student. Now is not consdered to be known, q is unknown and the prior is adapated in this way. Results in the uncertainnty you have in the output. The uncertainty you have in the distribution is reflected in the new prior. This parameter of the student, we call the degrees of freedom, from that range (25 - 30) onward student is not much different from Gaussian.

**This is nice because** this inflation of the tails happens naturally. Very automatcially results in Gaussian when N is large enough.

**Question: Why do you know less??**

Before the q of the bayes linear predicted was assumed to be known.

Precision of this new distribution is scaled by the degrees of freedom.

High-level analysis:

w{Bayes} = (prior_precision + data precision)^{-1} q phi^{T} t

If you compare these expressions, q (unknown) has been replaced by g (chosen)

g -> q

Q^{-1} = var(w|t,x) = (D + q \phi^{T} phi)^{-1}

If you need to specify g, how? Hierarchical / Using "Mixtures of g priors" with a distribution of g put a hyper distribution on g. w given q, q given g

If you take this prior, multiply by the likelihood the posterior you get out, you get this result you will discover that (Fast but dangerous if unfamiliar) the right posterior

*What is the right posterior?*

* You have at least as many observations as features (N gte M + 1)
* K = ...g ~> inf, when plugging in g = inf, you would take out g-inv which cancels it out and g^{-1}D goes to zero (this is all provided phitphi is invertible)

w0 - if your prior that all other w are 0 than w0 should be the mean of your input. Otherwise it exactly the difference btw the average of the input and the impact of the features.

p(q, w0, w1:m) = p(q|w0)p(w1:m|q)

The clever way is to say the precision on w,q with 0 in the D.

Does it make sense to say (in the prior) that the w's are aprior independent? Only when there is zero correlation / zero covariance




























