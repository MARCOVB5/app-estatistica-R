library(shiny)

ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      .container-fluid {
        max-width: 800px;
        margin: 0 auto;
      }
      .well {
        background-color: #f9f9f9;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      }
      .output-text {
        font-size: 16px;
        color: #333;
      }
      .numeric-input {
        margin-bottom: 15px;
      }
      .header {
        text-align: center;
        margin-bottom: 30px;
      }
    "))
  ),
  
  div(class = "header",
      h1("Calculation App")
  ),
  
  div(class = "well",
      numericInput("obs", "Média :", 1, min = -100, max = 100, width = "100%"),
      numericInput("obs2", "Valor Z :", 1, min = -3, max = 3, width = "100%"),
      numericInput("obs3", "Desvio Padrão :", 1, min = 0.1, max = 1000, width = "100%"),
      numericInput("obs4", "Tamanho Amostra (n):", 1, min = 1, max = 1000, width = "100%"),
      
      textOutput("value"),
      textOutput("value2")
  )
)

server <- function(input, output) {
  output$value <- renderText({
    LI <- (input$obs - input$obs2 * input$obs3 / sqrt(input$obs4))
    paste("Resultado:", LI)
  })
  
  output$value2 <- renderText({
    LS <- (input$obs + input$obs2 * input$obs3 / sqrt(input$obs4))
    paste("Resultado2:", LS)
  })
}

shinyApp(ui, server)

