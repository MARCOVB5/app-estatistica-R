# Carregar a biblioteca shiny
library(shiny)

# Definir a interface do usuário
ui <- fluidPage(
    titlePanel("Cálculo de Probabilidade Hipergeométrica"),
    
    sidebarLayout(
        sidebarPanel(
            numericInput("m", "Número total de bolas vermelhas (m):", value = 4, min = 0),
            numericInput("n", "Número total de bolas azuis (n):", value = 6, min = 0),
            numericInput("k", "Número de bolas retiradas (k):", value = 3, min = 1),
            numericInput("x", "Número de bolas vermelhas desejadas (x):", value = 2, min = 0),
            actionButton("calculate", "Calcular")
        ),
        
        mainPanel(
            h3("Resultado"),
            textOutput("result")
        )
    )
)

# Definir a lógica do servidor
server <- function(input, output) {
    observeEvent(input$calculate, {
        # Número total de bolas
        total <- input$m + input$n
        
        # Calcular a probabilidade usando a distribuição hipergeométrica
        prob <- dhyper(input$x, input$m, input$n, input$k)
        
        # Exibir o resultado
        output$result <- renderText({
            paste("A probabilidade de extrair exatamente", input$x, "bolas vermelhas é:", round(prob, 4))
        })
    })
}

# Rodar o aplicativo Shiny
shinyApp(ui = ui, server = server)

