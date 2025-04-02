# import Shiny library
library(shiny)
# define UI component
ui <- fluidPage(titlePanel("Dice Roller App"), sidebarLayout(sidebarPanel(numericInput("dice",
  "Number of Dice", value = 1, min = 1, step = 1)  #number of dice input
,
  actionButton("roll", "Roll Dice")  #button to roll dice
),
  mainPanel(textOutput("diceRollSum")  #dice roll sum text output
,
    textOutput("diceRollValues")  #dice roll values text output
)))
server <- function(input, output) {
  # when roll dice button is pressed
  observeEvent(input$roll, {
    # roll dice
    diceRolls = sample(1:6, input$dice, replace = TRUE)
    # set output to sum of dice rolls
    output$diceRollSum <- renderText(paste("Total Dice: ",
      sum(diceRolls)))
    # set output to values of dice rolls
    output$diceRollValues <- renderText(paste("Dice Rolls by Number: \n",
      paste(names(table(diceRolls)), table(diceRolls),
        sep = ": ", collapse = "\n")))
  })
}

shinyApp(ui = ui, server = server)  #run the Shiny web app server
