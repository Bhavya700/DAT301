
library(shiny)
library(ggplot2)
library(gridExtra)

shinyServer(function(input, output) {
  output$cltPlot <- renderPlot({
    n <- input$samplesize
    m <- input$meansize
    
    if (input$dist == "uniform") {
      data <- matrix(runif(n * m, min = 0, max = 10), nrow = n) 
    } else if (input$dist == "exponential") {
      data <- matrix(rexp(n * m, rate = 0.5), nrow = n)
    } else if (input$dist == "binomial") {
      data <- matrix(rbinom(n * m, size = 20, prob = 0.5), nrow = n)
    }
    
    sample_means <- rowMeans(data)
    
    raw_sample_plot <- ggplot(data = data.frame(x = data[1, ]), aes(x = x)) +
      geom_histogram(aes(y = ..density..), bins = 30, color = "black", fill = "lightgreen") +
      labs(title = paste("Raw Sample Data from", input$dist, "Distribution"),
           x = "Values", 
           y = "Density") +
      theme_minimal()
    
    clt_plot <- ggplot(data = data.frame(x = sample_means), aes(x = x)) +
      geom_histogram(aes(y = ..density..), bins = 30, color = "black", fill = "lightblue") +
      stat_function(fun = dnorm, 
      args = list(mean = mean(sample_means), sd = sd(sample_means)), color = "red", size = 1) +
      labs(title = "Sample Means and CLT Convergence",
           x = "Sample Means", 
           y = "Density") + 
      theme_minimal()
    
    grid.arrange(raw_sample_plot, clt_plot, ncol = 2)
  })
})

