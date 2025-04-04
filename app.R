# import Shiny library
library(shiny)
# define UI component
ui <- fluidPage(titlePanel("Dice Roller App"), sidebarLayout(sidebarPanel(numericInput("dice",
  "Number of Dice", value = 1, min = 1, step = 1)  #number of dice input
,
  numericInput("sides", "Number of Sides", value = 6, min = 1,
    step = 1)  #number of sides input
, checkboxInput("rollList",
    "Show List of Dice Rolls", value = FALSE)  #checkbox to show list of dice rolls
,
  checkboxInput("plot", "Plot Dice Rolls")  #checkbox to plot list of dice rolls
,
  actionButton("roll", "Roll Dice")  #button to roll dice
),
  mainPanel(textOutput("diceRollSum")  #dice roll sum text output
,
    textOutput("diceRollValues")  #dice roll values text output
,
    textOutput("sortedDiceRollValues")  #sorted dice roll values text output
,
    textOutput("diceRollList")  #dice roll list text output
,
    plotOutput("diceRollPlot")  #dice roll plot output
)))
server <- function(input, output) {
  # when roll dice button is pressed
  observeEvent(input$roll, {
    # roll dice
    diceRolls <- sample(1:input$sides, input$dice, replace = TRUE)
    # table of dice rolls
    diceRollsTable <- table(diceRolls)
    # convert table to data frame
    sortedDiceRollsTable <- as.data.frame(diceRollsTable)
    # sort dice rolls
    sortedDiceRolls <- sortedDiceRollsTable[order(sortedDiceRollsTable$Freq,
      decreasing = TRUE), ]
    # set output to sum of dice rolls
    output$diceRollSum <- renderText(paste("Total Dice: ",
      sum(diceRolls)))
    # set output to values of dice rolls
    output$diceRollValues <- renderText(paste("Dice Rolls by Number: \n",
      paste(names(diceRollsTable), diceRollsTable, sep = ": ",
        collapse = "\n")))
    # set output to sorted values of dice rolls
    output$sortedDiceRollValues <- renderText(paste("Sorted Dice Rolls by Number: \n",
      paste(sortedDiceRolls$diceRolls, sortedDiceRolls$Freq,
        sep = ": ", collapse = "\n")))
    # show list of dice rolls if checkbox is checked
    if (input$rollList) {
      output$diceRollList <- renderText(paste("List of Dice Rolls: \n",
        paste(diceRolls, collapse = ", ")))
    } else {
      output$diceRollList <- renderText("")
    }
    # show plot of dice rolls if checkbox is checked
    if (input$plot) {
      output$diceRollPlot <- renderPlot({
        barplot(diceRollsTable, main = "Dice Rolls",
          xlab = "Dice", ylab = "Frequency", col = "blue")  #plot list of dice rolls
      })
    } else {
      output$diceRollPlot <- renderPlot({
        plot.new()  #render empty and blank plot
      })
    }
  })
}

shinyApp(ui = ui, server = server)  #run the Shiny web app server


