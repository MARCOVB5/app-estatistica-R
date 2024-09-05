library(shiny)

ui <- fluidPage(
  titlePanel("#2: Teste de Hipótese para Média"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("sample_mean", "Média Amostral:", 50, min = -100, max = 100),
      numericInput("pop_mean", "Média Populacional (H0):", 50, min = -100, max = 100),
      numericInput("sample_sd", "Desvio Padrão Amostral:", 8, min = 0.1, max = 1000),
      numericInput("sample_size", "Tamanho da Amostra:", 40, min = 1, max = 1000),
      actionButton("calc", "Calcular")
    ),
    
    mainPanel(
      h4("Valor do Teste t:"),
      verbatimTextOutput("t_value")
    )
  )
)

server <- function(input, output) {
  observeEvent(input$calc, {
    output$t_value <- renderText({
      t_stat <- (input$sample_mean - input$pop_mean) / (input$sample_sd / sqrt(input$sample_size))
      paste(round(t_stat, 4))
    })
  })
}

shinyApp(ui, server)

