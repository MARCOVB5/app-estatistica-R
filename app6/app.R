library(shiny)

ui <- fluidPage(
  titlePanel("#4: Regressão Linear Simples"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("slope", "Coeficiente Angular (β1):", 0.5, min = -10, max = 10, step = 0.01),
      numericInput("intercept", "Intercepto (β0):", 2, min = -100, max = 100),
      numericInput("independent", "Valor da Variável Independente (X):", 10, min = -100, max = 100),
      actionButton("calc", "Calcular")
    ),
    
    mainPanel(
      h4("Valor Previsto (Y):"),
      verbatimTextOutput("predicted_value")
    )
  )
)

server <- function(input, output) {
  observeEvent(input$calc, {
    output$predicted_value <- renderText({
      y_hat <- input$intercept + input$slope * input$independent
      paste(round(y_hat, 4))
    })
  })
}

shinyApp(ui, server)

