library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot

  output$plot <- renderPlot({
    plot(cars, type=input$plotType)
  })

  output$summary <- renderPrint({
    summary(cars)
  })

  output$table <- renderDataTable({
    cars
  }, options=list(pageLength=10))

  output$feature_extraction_examples <- renderUI({
    if (!input$feature_extraction_examples_visible) return()
    withMathJax('
      $$\\phi(x) = x$$
      $$\\phi(x_{j}) = (x_{j} - \\bar{x_{j}})/sd(x_{j})$$
      $$\\phi(x) = (1, x, 0.5(3x^{2} - 1), 0.5(5x^{3} - 3x), ...) (Legendre Polynomials)$$')
  })

  output$linear_regression <- renderUI({
    if (!input$linear_regression_visible) return()
    withMathJax('
      $$t | x \\backsim N(y(x), q^{-1}) \\Rightarrow  t = y(x) + \\epsilon, \\epsilon \\backsim N(0, q^{-1})$$
      $$ y(x) = \\phi(x)^{T}w = w_{0} + \\sum_{j=1}^{M} w_{j}\\phi{j}(x)$$
      single multivariate observation:
      $$t | x = N(\\phi w, (1/q)I)$$')
  })

  output$gauss_mle <- renderUI({
    if (!input$gauss_mle_visible) return()
    withMathJax('
      $$N(x|\\mu,\\Sigma) = normalconst * exp \\Bigg\\{ -\\frac{1}{2} (x - \\mu)^{T} \\Sigma^{-1} (x - \\mu) \\Bigg\\}$$
      Minimize:
      $$ -2log(p(t|x,w,q)) = -Nlog(q) + q(t - \\phi w)^{T}(t - \\phi w) + const$$
      To get:
      $$w_{mle} = (\\phi^{T}\\phi)^{-1}\\phi t$$
      $$q_{mle} = (\\frac{1}{N} e^{T}e)^{-1}$$')
  })
})
