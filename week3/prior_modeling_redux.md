# Prior Modeling

Referenced difference from _equivariance property of MLE_

I have to a little careful with Bayes, I haven't set up my beliefs to naturally adapt, should scale the prior of w on q. I'm adapting the nominal units of shrinkage to the nominal units of measurement. Adapting the variance to the units of measurement. It doesn't make sense to assume w1 and w2 have the same units of measurement.

Naturally adapts to different levels of noise. w ~ N(0, (q\delta)^{-1} I)

## Posterior Mean and variance

Q becomes a relation to our prior and the representation in the data. (Q = a\deltaI + q\phi^{T}\phi)

If I don't know what D is than what are we doing - change D with Q. This expresses your beliefs about shrinkage, how much Q should shrink?

w_{Bayes} = (D + \phi^{T}\phi)\phi^{T}t
_q and q^{-1} cancels_

Questions:

* Flat prior
* How M much greater than N drives an improper prior 'one that does not integrate'
