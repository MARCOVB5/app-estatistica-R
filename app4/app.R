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
      h1("Regressão Linear Simples")
  ),
  
  div(class = "well",
      numericInput("slope", "Coeficiente Angular (β1):", 0.5, min = -10, max = 10, step = 0.01, width = "100%"),
      numericInput("intercept", "Intercepto (β0):", 2, min = -100, max = 100, width = "100%"),
      numericInput("independent", "Valor da Variável Independente (X):", 10, min = -100, max = 100, width = "100%"),
      
      textOutput("predicted_value")
  )
)

server <- function(input, output) {
  output$predicted_value <- renderText({
    y_hat <- input$intercept + input$slope * input$independent
    paste("Valor Previsto (Y):", round(y_hat, 4))
  })
}

shinyApp(ui, server)

