# import Shiny library
library(shiny)
# define UI component
ui <- fluidPage(titlePanel("Dice Roller App"), sidebarLayout(sidebarPanel(numericInput("dice",
  "Number of Dice", value = 1, min = 1, step = 1)  #number of dice input
,
  numericInput("sides", "Number of Sides", value = 6, min = 1,
    step = 1)  #number of sides input
, actionButton("roll",
    "Roll Dice")  #button to roll dice
), mainPanel(textOutput("diceRollSum")  #dice roll sum text output
, textOutput("diceRollValues")  #dice roll values text output
, textOutput("sortedDiceRollValues")  #sorted dice roll values text output
)))
server <- function(input, output) {
  # when roll dice button is pressed
  observeEvent(input$roll, {
    # roll dice
    diceRolls <- sample(1:input$sides, input$dice, replace = TRUE)
    # sort dice rolls
    sortedDiceRolls <- diceRolls[order(diceRolls, decreasing = TRUE)]
    # set output to sum of dice rolls
    output$diceRollSum <- renderText(paste("Total Dice: ",
      sum(diceRolls)))
    # set output to values of dice rolls
    output$diceRollValues <- renderText(paste("Dice Rolls by Number: \n",
      paste(names(table(diceRolls)), table(diceRolls),
        sep = ": ", collapse = "\n")))
    # set output to sorted values of dice rolls
    output$sortedDiceRollValues <- renderText(paste("Sorted Dice Rolls by Number: \n",
      paste(names(table(sortedDiceRolls)), table(sortedDiceRolls),
        sep = ": ", collapse = "\n")))
  })
}

shinyApp(ui = ui, server = server)  #run the Shiny web app server
