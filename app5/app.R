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
      h1("Teste t-Pareado")
  ),
  
  div(class = "well",
      numericInput("mean_diff", "Média das Diferenças (d̄):", 5, min = -100, max = 100, width = "100%"),
      numericInput("sd_diff", "Desvio Padrão das Diferenças (sd):", 2, min = 0.1, max = 1000, width = "100%"),
      numericInput("sample_size", "Tamanho da Amostra:", 15, min = 1, max = 1000, width = "100%"),
      
      textOutput("t_paired")
  )
)

server <- function(input, output) {
  output$t_paired <- renderText({
    t_stat <- input$mean_diff / (input$sd_diff / sqrt(input$sample_size))
    paste("Valor do Teste t-Pareado:", round(t_stat, 4))
  })
}

shinyApp(ui, server)

