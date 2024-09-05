library(shiny)

ui <- fluidPage(
  titlePanel("Intervalo de Confiança para Proporção"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("successes", "Número de Sucessos:", 120, min = 0, max = 200),
      numericInput("sample_size", "Tamanho da Amostra:", 200, min = 1, max = 1000),
      numericInput("z_value", "Valor Crítico Z:", 1.96, min = -3, max = 3, step = 0.01),
      actionButton("calc", "Calcular")
    ),
    
    mainPanel(
      h4("Intervalo de Confiança:"),
      verbatimTextOutput("conf_interval")
    )
  )
)

server <- function(input, output) {
  observeEvent(input$calc, {
    output$conf_interval <- renderText({
      p_hat <- input$successes / input$sample_size
      margin_error <- input$z_value * sqrt(p_hat * (1 - p_hat) / input$sample_size)
      LI <- p_hat - margin_error
      LS <- p_hat + margin_error
      paste("[", round(LI, 4), ", ", round(LS, 4), "]")
    })
  })
}

shinyApp(ui, server)

