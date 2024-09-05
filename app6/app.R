library(shiny)

x <- seq(1, 10, by = 0.1)
y <- 3 + 4 * x + rnorm(length(x), 0, 1)

ui <- fluidPage(
  titlePanel("Previsão Linear com Regressão"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("obs", "Valor x:", 1, min = -100, max = 100),
      actionButton("calc", "Calcular")
    ),
    
    mainPanel(
      h4("Resultado:"),
      verbatimTextOutput("value")
    )
  )
)

server <- function(input, output) {
  observeEvent(input$calc, {
    output$value <- renderText({
      ajuste <- lm(y ~ x)
      previsto <- ajuste$coefficients[1] + ajuste$coefficients[2] * input$obs
      paste("Previsão:", previsto)
    })
  })
}

shinyApp(ui, server)

