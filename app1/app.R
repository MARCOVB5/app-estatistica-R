library(shiny)

ui <- fluidPage(
  # Add some CSS styles
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
  
  # App title
  div(class = "header",
      h1("Intervalo de Confiança para Proporção")
  ),
  
  # Main content
  div(class = "well",
      numericInput("successes", "Número de Sucessos:", 120, min = 0, max = 200, width = "100%"),
      numericInput("sample_size", "Tamanho da Amostra:", 200, min = 1, max = 1000, width = "100%"),
      numericInput("z_value", "Valor Crítico Z:", 1.96, min = -3, max = 3, step = 0.01, width = "100%"),
      
      textOutput("conf_interval")
  )
)

server <- function(input, output) {
  output$conf_interval <- renderText({
    p_hat <- input$successes / input$sample_size
    margin_error <- input$z_value * sqrt(p_hat * (1 - p_hat) / input$sample_size)
    LI <- p_hat - margin_error
    LS <- p_hat + margin_error
    paste("Intervalo de Confiança: [", round(LI, 4), ", ", round(LS, 4), "]")
  })
}

shinyApp(ui, server)

