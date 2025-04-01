library(shiny)
ui <- fluidPage(titlePanel("Dice Roller App"), sidebarLayout(sidebarPanel(numericInput("dice",
  "Number of Dice", value = 1, min = 1), actionButton("roll",
  "Roll Dice")), mainPanel(textOutput("output"))))
server <- function(input, output) {
  observeEvent(input$roll, {
    diceRolls = sample(1:6, input$dice, replace = TRUE)
    output$output <- renderText(paste("Total dice: ", sum(diceRolls)))
  })
}

shinyApp(ui = ui, server = server)
