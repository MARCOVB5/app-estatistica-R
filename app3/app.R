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
      h1("Teste de Hipótese para Proporção")
  ),
  
  div(class = "well",
      numericInput("successes", "Número de Sucessos:", 150, min = 0, max = 250, width = "100%"),
      numericInput("sample_size", "Tamanho da Amostra:", 250, min = 1, max = 1000, width = "100%"),
      numericInput("pop_proportion", "Proporção Populacional (H0):", 0.5, min = 0, max = 1, step = 0.01, width = "100%"),
      
      textOutput("z_value")
  )
)

server <- function(input, output) {
  output$z_value <- renderText({
    p_hat <- input$successes / input$sample_size
    z_stat <- (p_hat - input$pop_proportion) / sqrt(input$pop_proportion * (1 - input$pop_proportion) / input$sample_size)
    paste("Valor do Teste z:", round(z_stat, 4))
  })
}

shinyApp(ui, server)

