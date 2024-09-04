library(shiny)

ui <- fluidPage(
  titlePanel("#5: Teste t-Pareado"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("mean_diff", "Média das Diferenças (d̄):", 5, min = -100, max = 100),
      numericInput("sd_diff", "Desvio Padrão das Diferenças (sd):", 2, min = 0.1, max = 1000),
      numericInput("sample_size", "Tamanho da Amostra:", 15, min = 1, max = 1000),
      actionButton("calc", "Calcular")
    ),
    
    mainPanel(
      h4("Valor do Teste t-Pareado:"),
      verbatimTextOutput("t_paired")
    )
  )
)

server <- function(input, output) {
  observeEvent(input$calc, {
    output$t_paired <- renderText({
      t_stat <- input$mean_diff / (input$sd_diff / sqrt(input$sample_size))
      paste(round(t_stat, 4))
    })
  })
}

shinyApp(ui, server)

