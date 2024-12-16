
library(rsconnect)
library(shiny)

shinyUI(fluidPage(
    titlePanel("Central Limit Theorem"),
    
    p("The central limit theorem (CLT) states that the distribution of sample means approximates a 
      normal distribution as the sample size gets larger, regardless of the population's distribution."),
    p("Sample sizes equal to or greater than 30 are often considered sufficient for the CLT to hold."),
    p("Below, you can explore the CLT by selecting different distributions, adjusting the number of samples, 
      and setting the sample size for each simulation"),
    br(),
    sidebarLayout(
      sidebarPanel(
        selectInput("dist", 
                    label = "Choose Distribution",
                    choices = list("Uniform" = "uniform", 
                                   "Exponential" = "exponential", 
                                   "Binomial" = "binomial")),
        sliderInput("samplesize", 
                    label = "Number of Samples",
                    min = 100, max = 5000, value = 1000),
        sliderInput("meansize", 
                    label = "Sample Size for Each Simulation",
                    min = 2, max = 100, value = 30)
      ),
      mainPanel(
        plotOutput("cltPlot")
      )
    )
))

