library(shiny)

ui <- fluidPage(
  titlePanel("Cálculo de Tamanho Amostral para Estimar a Proporção"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("conf_level_prop", "Nível de Confiança (%)", 90, min = 90, max = 99, step = 1),
      numericInput("error_margin_prop", "Margem de Erro (%)", 5, min = 0.1, max = 10, step = 0.1),
      actionButton("calc_prop", "Calcular Tamanho Amostral")
    ),
    
    mainPanel(
      h4("Resultado"),
      verbatimTextOutput("sample_size_prop")
    )
  )
)

server <- function(input, output) {
  
  observeEvent(input$calc_prop, {
    z_value_prop <- qnorm((input$conf_level_prop / 100) + (1 - input$conf_level_prop / 100) / 2)
    p <- 0.5 
    n_prop <- (z_value_prop ^ 2 * p * (1 - p)) / (input$error_margin_prop / 100) ^ 2
    output$sample_size_prop <- renderText({
      paste("Tamanho amostral necessário para estimar a proporção:", ceiling(n_prop), "clientes")
    })
  })
}

shinyApp(ui, server)

