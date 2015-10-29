library(shiny)

library(metRology)
library(splines)
library(MASS)

phix <- function(x, M, basis_type) {
  phi <- rep(0, M)
  if (basis_type == "poly") {
    for (i in 1:(M)) {
      phi[i] <- x**i
    }
  }
  if (basis_type == "Gauss") {
    phi[1] <- 1
    for (i in 2:(M+1)) {
      phi[i] <- exp(-((x-i/(M))**2)/0.1)
    }
    
  }
  phi
}

post.params <- function(data, M, basis_type, delta, q, a0, b0, og) {
  N = length(data$x)
  phi = phix(data$x[1], M, basis_type)
  for (i in 2:length(data$x)) {
    phi_ <- phix(data$x[i], M, basis_type)
    phi = rbind(phi, phi_)  
  }

  data.precision <- 1 / (sd(data$t)^2)

  # Estimate parameters using MLE
  mle <- lm(data$t ~ phi)
  mle.params <- mle$coefficients
  mle.var <- sd(mle$fitted.values)^2
  mle.precision <- 1 / mle.var
  mle.fitted.values <- mle$fitted.values
  
  # Estimate parameters using Bayes - claiming to know q
  regularization.D <- delta * diag(ncol(phi))
  bayes.Q <- regularization.D + q * (t(phi) %*% phi)
  bayes.params <- solve(bayes.Q) %*% (q * t(phi) %*% data$t)
  bayes.fitted.values <- phi %*% bayes.params
  bayes.var <- sd(bayes.fitted.values) ^ 2
  bayes.precision <- 1 / bayes.var

  # Estimate parameters using Bayes and sNG - setting 'g' to 1
  g <- og
  bayes.sng.Dprime <- 1/g * (regularization.D + g * (t(phi) %*% phi))
  bayes.sng.aprime <- a0 + N/2
  bayes.sng.K.identity <- diag(nrow = N, ncol = N)
  bayes.sng.K <- g * phi %*% solve(regularization.D + g * t(phi) %*% phi) %*% t(phi)
  bayes.sng.bprime <- b0 + (1/2) * t(data$t) %*% (bayes.sng.K.identity - bayes.sng.K) %*% data$t
  bayes.sng.fitted.values <- bayes.sng.K %*% data$t
  
  return(list(
    mle.fitted.values = mle.fitted.values,
    bayes.fitted.values = bayes.fitted.values,
    bayes.sng.fitted.values = bayes.sng.fitted.values,
    bayes.params = bayes.params,
    bayes.sng.bprime = bayes.sng.bprime,
    bayes.sng.aprime = bayes.sng.aprime,
    bayes.sng.Dprime = bayes.sng.Dprime))
}

predict.t.studentsT <- function(data, x, M, basis_type, delta, q, a, b, og) {
  test.x <- x
  bayes.post.params <- post.params(data, M, basis_type, delta, q, a, b, og)

  test.y <- matrix(nrow = length(test.x), ncol = 2)
  dimnames(test.y)[[2]] <- list("test.x", "test.y")
  # create phi(testx) by sending all the test x to phix
  phi.test.x <- matrix(nrow = length(test.x), ncol = M+1)
  for (n in 1:length(test.x)) {
    test.y[n,"test.x"] <- test.x[n]
    phi.test.x[n,] <- c(phix(test.x[n], M, basis_type))
  }

  for (n in 1:nrow(phi.test.x)) {
    xphix <- phi.test.x[n,]

    F <- solve(1 + t(xphix) %*% solve(bayes.post.params$bayes.sng.Dprime) %*% xphix)
    test.y[n,"test.y"] <- rt.scaled(
      n = 1,
      mean = t(xphix) %*% bayes.post.params$bayes.params,
      sd = 1/sqrt(bayes.post.params$bayes.sng.aprime/bayes.post.params$bayes.sng.bprime * F),
      df = bayes.post.params$bayes.sng.aprime * 2)
  }

  return(test.y)
}

shinyServer(function(input, output) {
  output$multiModelPlot <- renderPlot({
    M <- input$features
    delta <- input$delta
    q <- input$q
    a0 <- -1/2
    b0 <- 0
    basis_type <- 'Gauss'
    data <- read.csv('curve_data.txt', sep = ' ')
    og <- input$g

    result <- post.params(data, M, basis_type, delta, q, a0, b0, og)
    plot(c(0,1), c(-1,1), type="n")
    points(data$x, data$t, col = 'firebrick', pch = 21, bg = 'firebrick')
    lines(predict(splines::interpSpline(data$x, result$mle.fitted.values)), col = 'dodgerblue4')
    lines(predict(splines::interpSpline(data$x, result$bayes.fitted.values)), col = 'darkseagreen')
    lines(predict(splines::interpSpline(data$x, result$bayes.sng.fitted.values)), col = 'darkorange3')
    legend(0, 0, legend = c("mle", "bayes", "bayes sng"), lty=c(1,1), lwd=c(2.5,2.5),col=c("green", "darkseagreen", "darkorange3"))
  })

  output$studentTDistribution <- renderPlot({
    data <- read.csv('curve_data.txt', sep = ' ')
    M <- input$features
    delta <- input$delta
    q <- input$q
    a0 <- -1/2
    b0 <- 0
    basis_type <- 'Gauss'
    og <- input$g

    test.x <- seq(0,1,1/10)

    plot(data, col = 'firebrick')
    for (n in 1:100) {
      test.y <- predict.t.studentsT(data, test.x, M, basis_type, delta, q, a0, b0, og)
      lines(predict(splines::interpSpline(test.y[,'test.x'], test.y[,'test.y'])), col = 'darkseagreen') 
    }
    points(data, col = 'firebrick', pch = 21, bg = 'firebrick') 
  })
})
