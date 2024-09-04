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
      h1("Distribuição Hipergeométrica")
  ),
  
  div(class = "well",
      numericInput("red_balls", "Número de Bolas Vermelhas:", 4, min = 0, max = 10, width = "100%"),
      numericInput("blue_balls", "Número de Bolas Azuis:", 6, min = 0, max = 10, width = "100%"),
      numericInput("drawn_balls", "Número de Bolas Retiradas:", 3, min = 1, max = 10, width = "100%"),
      numericInput("successes", "Número de Sucessos Desejado (Bolas Vermelhas):", 2, min = 0, max = 3, width = "100%"),
      
      textOutput("hypergeometric_prob")
  )
)

server <- function(input, output) {
  output$t_paired <- renderText({
    t_stat <- input$mean_diff / (input$sd_diff / sqrt(input$sample_size))
    paste("Valor do Teste t-Pareado:", round(t_stat, 4))
  })
}

shinyApp(ui, server)

