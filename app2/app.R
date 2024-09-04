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
      h1("Teste de Hipótese para Média")
  ),
  
  div(class = "well",
      numericInput("sample_mean", "Média Amostral:", 50, min = -100, max = 100, width = "100%"),
      numericInput("pop_mean", "Média Populacional (H0):", 50, min = -100, max = 100, width = "100%"),
      numericInput("sample_sd", "Desvio Padrão Amostral:", 8, min = 0.1, max = 1000, width = "100%"),
      numericInput("sample_size", "Tamanho da Amostra:", 40, min = 1, max = 1000, width = "100%"),
      
      textOutput("t_value")
  )
)

server <- function(input, output) {
  output$t_value <- renderText({
    t_stat <- (input$sample_mean - input$pop_mean) / (input$sample_sd / sqrt(input$sample_size))
    paste("Valor do Teste t:", round(t_stat, 4))
  })
}

shinyApp(ui, server)

