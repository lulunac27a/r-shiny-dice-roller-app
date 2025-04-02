# import Shiny library
library(shiny)
# define UI component
ui <- fluidPage(titlePanel("Dice Roller App"), sidebarLayout(sidebarPanel(numericInput("dice",
  "Number of Dice", value = 1, min = 1, step = 1)  #number of dice input
,
  actionButton("roll", "Roll Dice")  #button to roll dice
),
  mainPanel(textOutput("output")  #text output
)))
server <- function(input, output) {
  # when roll dice button is pressed
  observeEvent(input$roll, {
    # roll dice
    diceRolls = sample(1:6, input$dice, replace = TRUE)
    # set output to sum of dice rolls
    output$output <- renderText(paste("Total Dice: ", sum(diceRolls)))
  })
}

shinyApp(ui = ui, server = server)  #run the Shiny web app server
