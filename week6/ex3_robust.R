data <- read.csv("synthetic_regression.txt",sep="", nrows=300)
data = data[,c(1:31)]

# create feature matrix and t

phi = as.matrix(cbind(1,data[,c(2:31)]))
t = as.vector(data[,1])

# computing coefficients, std errors and deviance for basic MLE regression

N <- nrow(data)
beta <- as.vector(summary(lm(t ~ phi))$coefficients[,1])
std.e <- as.vector(summary(lm(t ~ phi))$coefficients[,2])
residuals <- as.vector(lm(t ~ phi)$residuals)

plotting.betas.mle = data.frame(Coefficients = beta, Std.Error = std.e)
for (i in 1:31) {ifelse(i == 1, row.names(plotting.betas.mle)[i] <- "Intercept", row.names(plotting.betas.mle)[i] <- i - 1)}

# computing robust coefficients, std errors and deviance 

iter <- 100
nu <- 10
q <- 1/var(t) # setting initial value for q that will make covergence faster
 
# eta <- rep(1, nrow(phi))
log.like <- rep(0, iter)
Q <- rep(0, iter)
error <- t - mean(t)


for(i in 1:iter){
  
  # second step of EM algorithm: expected value of eta with current w and q
  eta <- as.vector((nu + 1)/(nu + q*(error^2) - 2))
  
  # first step of EM algorithm: estimate current q and w 
  W <- solve(t(phi) %*% diag(eta) %*% phi , t(phi) %*% diag(eta) %*% t)
  error <- as.vector(t - phi %*% W)
  q <- as.numeric(solve((1/N)*t(error) %*% diag(eta) %*% error))
  
  log.like[i] <- (N/2)*log(q) + (-q/2)*(t(error) %*% diag(eta) %*% error) 
  
  Q[i] <- q
  
  if(i > 1){
    if(log.like[i] - log.like[i-1] < 1e-4){
      cat("number of iterations",i)
      break
    }
  }
}

# library(MASS)
# r.result = rlm(t ~ phi[,-1], weigths = eta) 

log.like <- log.like[1:i]
Q <- Q[1:i]

#W
#ematrix <- matrix(0,31,31)
#for(j in 1:N){
 # c <- as.numeric((nu + 1)*(nu - 2 - q*(e[j]^2))/((nu + q*(e[j]^2) -2)^2))
  #summ <- c*X[j,] %*% t(X[j,])
  #ematrix = ematrix + summ
#}

exp.eta = as.numeric((nu + 1)*(nu - 2 - q*(error^2))/((nu + q*(error^2) -2)^2))
precision = q*(t(phi) %*% diag(exp.eta) %*% phi)
cov.matrix <- solve(precision)
std.e.rob = sqrt(diag(cov.matrix))
beta.rob = W

plotting.betas = data.frame(Coefficients = beta.rob, Std.Error = std.e.rob)
for (i in 1:31) {ifelse(i == 1, row.names(plotting.betas)[i] <- "Intercept", row.names(plotting.betas)[i] <- i - 1)}
  
#robust.se <- data.frame(value = W,se = sqrt(diag(var)))
#row.names(robust.se)[1] <- "Intercept"


library(ggplot2)

robust.plot <- ggplot() + geom_point(data = plotting.betas, 
                           aes(x = factor(row.names(plotting.betas),
                                          levels = row.names(plotting.betas)), y = Coefficients),
                           colour = 'blue', size = 3) + 
  
     geom_errorbar(data = plotting.betas, 
                aes(x = factor(row.names(plotting.betas),
                               levels = row.names(plotting.betas)), 
                    y = Coefficients, ymax = Coefficients + 1.96*std.e.rob, ymin=Coefficients - 1.96*std.e.rob),
                colour = 'red', width = 0.4) + 
     labs(x= "Regressors",y="Coefficient +/- 1.96 standard error",
       title = "Robust")

robust.plot2 <- ggplot() + geom_point(data = plotting.betas, 
                                     aes(x = Coefficients, 
                                         y = factor(row.names(plotting.betas), levels = row.names(plotting.betas))),
                                     colour = 'black', size = 3) + 
  
  geom_errorbarh(data = plotting.betas, 
                aes(x = Coefficients, xmax = Coefficients + 1.96*std.e.rob, xmin=Coefficients - 1.96*std.e.rob, 
                    y = factor(row.names(plotting.betas), levels = row.names(plotting.betas))),
                colour = 'black', width = 0.4) + 
  labs(x= "Regressors",y="Coefficient +/- 1.96 standard error",
       title = "Robust")

mle.plot <- ggplot() + geom_point(data = plotting.betas.mle, 
                                  aes(x = factor(row.names(plotting.betas.mle),
                                                 levels = row.names(plotting.betas.mle)), y = Coefficients),
                                  colour = 'blue', size = 3) + 
  
  geom_errorbar(data = plotting.betas.mle, 
                aes(x = factor(row.names(plotting.betas.mle),
                               levels = row.names(plotting.betas.mle)), 
                    y = Coefficients, ymax = Coefficients + 1.96*std.e, ymin=Coefficients - 1.96*std.e),
                colour = 'red', width = 0.4) + 
  labs(x= "Regressors",y="Coefficient +/- 1.96 standard error",
       title = "MLE")

mle.plot2 <- ggplot() + geom_point(data = plotting.betas.mle, 
                                     aes(x = Coefficients, 
                                         y = factor(row.names(plotting.betas.mle), levels = row.names(plotting.betas.mle))),
                                     colour = 'black', size = 3) + 
  
  geom_errorbarh(data = plotting.betas.mle, 
                 aes(x = Coefficients, xmax = Coefficients + 1.96*std.e.rob, xmin=Coefficients - 1.96*std.e.rob, 
                     y = factor(row.names(plotting.betas.mle), levels = row.names(plotting.betas.mle))),
                 colour = 'black', width = 0.4) + 
  labs(x= "Regressors",y="",
       title = "MLE")


multiplot <- function(..., plotlist = NULL, file, cols = 1, layout = NULL) {
  require(grid)
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  numPlots = length(plots)
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel ncol: Number of columns of plots nrow: Number of rows
    # needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)), ncol = cols,
                     nrow = ceiling(numPlots/cols))
  }
  if (numPlots == 1) {
    print(plots[[1]])
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row, layout.pos.col = matchidx$col))
    }
  }
}

multiplot(robust.plot2, mle.plot2, col=2, layout = matrix(c(1,2), nrow=1, byrow=TRUE))


## excercise 3.2

dev.res.mle <- (residuals^2)/var(t)
dev.res.rob = (error^2)*(q*eta)

layout(matrix(c(1,2), 1, 2))
plot(dev.res.mle, ylab = "MLE deviance", xlab = "Observation") + 
  abline(a = quantile(dev.res.mle,0.99),b= 0)

plot(dev.res.rob, ylab = "Robust deviance", xlab = "Observation") +
  abline(a = quantile(dev.res.mle,0.99),b= 0)

## Excercise 3.3

plot(log.like, ylab = "Log-Likelihood at each iteration", xlab = "Iteration", type="b")

## Excercise 3.4 

N <- 300
nu <- seq(2.1,300,0.2)
log.like <- rep(200)

for(j in 1:200){
  W <- plotting.betas$value
  q <- 1/var(t)
  error <- t - mean(t)
  for(i in 1:10){
    eta <- as.vector((nu[j] + 1)/(nu[j] + q*(error^2) - 2))
    
    W <- solve(t(phi) %*% diag(eta) %*% phi , t(phi) %*% diag(eta) %*% t)
    e <- as.vector(t - phi %*% W)
    q <- as.numeric(solve((1/N)*t(error) %*% diag(eta) %*% error))
    
    log.like[j] <- (-1/2)*(t(error) %*% diag(q*eta) %*% e) + (N/2)*log(q)
  }
  if(j > 1){
    if(log.like[j] - log.like[j-1] < 1e-4){
      cat("Convergence reached at nu =",nu[j])
      break
    }
  }
}

log.like <- log.like[1:j]
nu = nu[1:j]
layout(matrix(1, 1, 1))
plot(y=log.like, x=nu, ylab = "Log-Likelihood", xlab = "Value of nu", type="b")
