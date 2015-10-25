library(shiny)

wald.test <- function(y, x, alpha) {
  my <- mean(y)
  mx <- mean(x)

  # stat: wald test statistic
  stat <- (mx - my - 0) / sqrt((var(x)/length(x)) + (var(y)/length(y)))
  # pval of stat
  # This would be qnorm(1 - stat/2) if we were interested in a 2-tailed test
  pval <- pnorm(stat)
  # pval of alpha
  alpha_stat <- qnorm(1 - alpha)
  # Reject H0 if stat > alpha_pval
  reject <- stat < -alpha_stat
  list(stat, pval, reject)
}

mann.whitney.test <- function(y, x, alpha) {
  ny <- length(y)
  nx <- length(x)
  pooled <- c(y, x)
  ranks <- rank(pooled)
  ranky <- ranks[1:ny]
  sumranky <- sum(ranky)

  U <- ny*nx + ((ny*(ny+1))/2) - sumranky
  mU <- ny*nx/2
  varU <- ((ny*nx) * (ny+nx+1)) / 12
  sdU <- sqrt(varU)

  stat <- (U - mU) / sdU
  pval <- pnorm(stat)
  alpha_stat <- qnorm(1 - alpha)
  # If the alternative is the one-sided hypothesis than the location of
  #   population 1 is higher than that of population 2, the decision rule is
  #   reject H0 when stat < -z(alpha).
  reject <- stat < -alpha_stat

  list(stat, pval, reject)
}

shinyServer(function(input, output) {
  output$waldPlot <- renderPlot({
    alpha <- input$alpha
    ntests <- input$nsims
    sample_sizes <- seq(input$samplesizemin, input$samplesizemax, input$samplesizeinterval)
    reject <- matrix(nrow = ntests, ncol = length(sample_sizes))
    dimnames(reject)[[2]] <- sprintf('sample size = %d', sample_sizes)

    for (s in 1:length(sample_sizes)) {
      for (n in 1:ntests) {
        x <- input$meanx + rt(sample_sizes[s], 2.5)
        y <- input$meany + rt(sample_sizes[s], 2.5)
        test_result <- wald.test(y, x, alpha)
        reject[n,s] <- test_result[3][[1]]
      }
    }

    plot(sample_sizes,colMeans(reject*100),t='b',ylim=c(0,100),lwd=2,col='darkblue',ylab='Test Size',xlab='Sample Size')
  })

  output$mannWhitneyPlot <- renderPlot({
    alpha <- input$alpha
    ntests <- input$nsims
    sample_sizes <- seq(input$samplesizemin, input$samplesizemax, input$samplesizeinterval)
    reject <- matrix(nrow = ntests, ncol = length(sample_sizes))
    dimnames(reject)[[2]] <- sprintf('sample size = %d', sample_sizes)

    for (s in 1:length(sample_sizes)) {
      for (n in 1:ntests) {
        x <- input$meanx + rt(sample_sizes[s], 2.5)
        y <- input$meany + rt(sample_sizes[s], 2.5)
        test_result <- mann.whitney.test(y, x, alpha)
        reject[n,s] <- test_result[3][[1]]
      }
    }

    plot(sample_sizes,colMeans(reject*100),t='b',ylim=c(0,100),lwd=2,col='darkblue',ylab='Test Size',xlab='Sample Size')
  })
})
