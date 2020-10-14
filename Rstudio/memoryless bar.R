#Build a dashboard for Memoryless Bar where they can change parameters for their ordering 
#and see the effect it has on inventory over the long run

# last code ...
library(expm)
T <- matrix(c(0.95,0.05,0,0,0.75,0.2,0.05,0,0.2,0.55,0.2,0.05,0.2, 0.55,0.2,0.05), nrow = 4, byrow = TRUE)
colnames(T) = c(0,1,2,3)
rownames(T) = c(0,1,2,3)

T

T%^%2

T%^%5

T%^%20
T%^%60

## dashboard for the Memoryless Bar

library(shiny)

ui <- fluidPage(headerPanel('Memoryless Bar orders'),
                sliderInput(inputId = "num",  
                            label = " choose the Number of order ",  
                            value = 10 , min = 1 , max = 400 ),
                actionButton(inputId = "go",  
                             label = "Update the histogram"), 
                
                plotOutput("hist"),
                verbatimTextOutput("stats") 
                
                
                
)




server <- function(input, output) {
  data <- eventReactive(input$go, { 
    rnorm(input$num)  
  }) 
  
  
  output$hist<-renderPlot({ 
    title <- "orders "
    hist(data())
    output$stats <- renderPrint({ 
      summary(data()) 
    }) 
    
    
    
    
  })
  
}

shinyApp(ui = ui, server = server)