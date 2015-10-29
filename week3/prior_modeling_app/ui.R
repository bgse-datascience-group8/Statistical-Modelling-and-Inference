library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Prior Modeling with Bayes and sNG"),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("features",
        "features (M)",
        min = 0,
        max = 20,
        value = 6),
      sliderInput("q",
        "little known q (for Bayes)",
        min = 0,
        max = 100,
        value = 100),
      sliderInput("g",
        "mysterious red g (for Bayes SNG)",
        min = 0,
        max = 100,
        value = 1),
      sliderInput("delta",
        "delta",
        min = 0,
        max = 100,
        value = 1)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("MLE, Bayes and Bayes SNG", plotOutput("multiModelPlot")),
        tabPanel("Student T-distribution", plotOutput("studentTDistribution"))
      )
    )
  )
))
