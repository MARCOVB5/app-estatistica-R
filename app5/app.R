library(shiny)

ui <- fluidPage(
  titlePanel("#3: Teste de Hipótese para Proporção"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("successes", "Número de Sucessos:", 150, min = 0, max = 250),
      numericInput("sample_size", "Tamanho da Amostra:", 250, min = 1, max = 1000),
      numericInput("pop_proportion", "Proporção Populacional (H0):", 0.5, min = 0, max = 1, step = 0.01),
      actionButton("calc", "Calcular")
    ),
    
    mainPanel(
      h4("Valor do Teste z:"),
      verbatimTextOutput("z_value")
    )
  )
)

server <- function(input, output) {
  observeEvent(input$calc, {
    output$z_value <- renderText({
      p_hat <- input$successes / input$sample_size
      z_stat <- (p_hat - input$pop_proportion) / sqrt(input$pop_proportion * (1 - input$pop_proportion) / input$sample_size)
      paste(round(z_stat, 4))
    })
  })
}

shinyApp(ui, server)

