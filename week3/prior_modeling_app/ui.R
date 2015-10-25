library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Monte Carlo Simulations"),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("alpha",
        "Alpha",
        min = 0,
        max = 0.25,
        value = 0.05),
      sliderInput("nsims",
        "Number of simulations",
        min = 0,
        max = 1000,
        value = 100),
      numericInput("samplesizemin",
        label = h3("Sample Size Minimum"),
        value = 5),
      numericInput("samplesizeinterval",
        label = h3("Sample Size Interval"),
        value = 5),
      numericInput("samplesizemax",
        label = h3("Sample Size Maximum"),
        value = 150),
      numericInput("meanx",
        label = h3("Mean of X"),
        value = 1),
      numericInput("meany",
          label = h3("Mean of Y"),
          value = 1)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Wald Test", plotOutput("waldPlot")),
        tabPanel("Mann-Whitney Test", plotOutput("mannWhitneyPlot"))
      )
    )
  )
))
