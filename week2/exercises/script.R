library(MASS)

constructPhi <- function(features, M, basis_type) {
  phi <- matrix(nrow = length(xs), ncol = M + 1)
    # Construct a phi matrix that is phix for each value of phix(x, M, 'Gauss') and append to phi matrix
  for (i in 1:(length(xs))) {
    phi[i,] = phix(xs[i], M, basis_type)
  }
  phi
}

# Part 3: post.params
post.params <- function(training_data, M, basis_type, delta, q) {
  # regularization coefficient
  # training_data = curve_data
  # q = (1/0.1)^2
  # delta = 2.0
  # basis_type = 'Gauss'
  lambda = delta / q

  # Note: this requires the training data to have an x column
  xs = training_data$x
  # M = 9
  phi <- constructPhi(xs, M, basis_type)
  t = training_data$t
  
  # Slide 10 of Bayessian_regression.pdf
  w_Bayes = ginv(lambda * diag(M+1) + t(phi) %*% phi) %*% t(phi) %*% training_data$t

  D = delta * diag(M + 1)
  Q = D + q * (t(phi) %*% phi)

  # FIXME: RETURN Q?
  list(w_Bayes, Q)
}

M = 9
delta = 2.0
q = (1/0.1)^2

params <- post.params(curve_data, M, 'poly', delta, q)
w_Bayes <- params[1]
Q <- params[2]
result <- constructPhi(curve_data$x, M, 'poly') %*% w_Bayes

# Part 4: Plot
plot(curve_data, col = 'red')
# Don't know how to smooth this out :(
lines(y = result, x = curve_data$x, type = 'l', col = 'blue')
