library(shiny)

ui <- fluidPage(
  titlePanel("Intervalo de Confiança para Média"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("obs", "Média (μ):", 1, min = -100, max = 100),
      numericInput("obs2", "Valor Crítico (Z):", 1, min = -3, max = 3),
      numericInput("obs3", "Desvio Padrão (σ):", 1, min = 0.1, max = 1000),
      numericInput("obs4", "Tamanho Amostra (n):", 1, min = 1, max = 1000),
      actionButton("calc", "Calcular")
    ),
    
    mainPanel(
      h4("Resultado:"),
      verbatimTextOutput("value"),
      verbatimTextOutput("value2")
    )
  )
)

server <- function(input, output) {
  observeEvent(input$calc, {
    output$value <- renderText({
      LI <- (input$obs - input$obs2 * input$obs3 / sqrt(input$obs4))
      paste("Limite Inferior:", LI)
    })
    
    output$value2 <- renderText({
      LS <- (input$obs + input$obs2 * input$obs3 / sqrt(input$obs4))
      paste("Limite Superior:", LS)
    })
  })
}

shinyApp(ui, server)

