library(shiny)

ui <- fluidPage(
  titlePanel("Cálculo de Tamanho Amostral para Estimar a Média"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("conf_level_mean", "Nível de Confiança (%)", 95, min = 90, max = 99, step = 1),
      numericInput("error_margin_mean", "Margem de Erro (cm)", 2, min = 0.1, step = 0.1),
      numericInput("std_dev_mean", "Desvio Padrão Populacional (cm)", 10, min = 1, step = 0.1),
      actionButton("calc_mean", "Calcular Tamanho Amostral")
    ),
    
    mainPanel(
      h4("Resultado"),
      verbatimTextOutput("sample_size_mean")
    )
  )
)

server <- function(input, output) {
  
  observeEvent(input$calc_mean, {
    z_value_mean <- qnorm((input$conf_level_mean / 100) + (1 - input$conf_level_mean / 100) / 2)
    n_mean <- (z_value_mean * input$std_dev_mean / input$error_margin_mean) ^ 2
    output$sample_size_mean <- renderText({
      paste("Tamanho amostral necessário para estimar a média:", ceiling(n_mean), "alunos")
    })
  })
}

shinyApp(ui, server)
