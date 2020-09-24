library(shiny)
library(tidyverse)
library(lubridate)

source('R/initialize.R')

# Define UI for application that draws a histogram
ui <- navbarPage(
  title = 'MealPlanneR'
  , tabPanel(
    title = 'Plan Meals'
    ,
    sidebarLayout(
      sidebarPanel(
               dateInput(
                 inputId = 'in_startdate'
                 , label = 'Start Date'
                 , value = today() + 1
                 , format = 'm/d/yyyy'
               )
               , width = 2
      ),
      mainPanel(
        h2(tags$b(textOutput('date0'))),
        f_dayplan_inputs(0, 1),
        f_dayplan_inputs(0, 2),
        f_dayplan_inputs(0, 3)
        , h2(tags$b(textOutput('date1'))),
        f_dayplan_inputs(1, 1),
        f_dayplan_inputs(1, 2),
        f_dayplan_inputs(1, 3),
        h2(tags$b(textOutput('date2'))),
        f_dayplan_inputs(2, 1),
        f_dayplan_inputs(2, 2),
        f_dayplan_inputs(2, 3),
        h2(tags$b(textOutput('date3'))),
        f_dayplan_inputs(3, 1),
        f_dayplan_inputs(3, 2),
        f_dayplan_inputs(3, 3),
        h2(tags$b(textOutput('date4'))),
        f_dayplan_inputs(4, 1),
        f_dayplan_inputs(4, 2),
        f_dayplan_inputs(4, 3),
        h2(tags$b(textOutput('date5'))),
        f_dayplan_inputs(5, 1),
        f_dayplan_inputs(5, 2),
        f_dayplan_inputs(5, 3),
        h2(tags$b(textOutput('date6'))),
        f_dayplan_inputs(6, 1),
        f_dayplan_inputs(6, 2),
        f_dayplan_inputs(6, 3)
        , width = 10
      )
      , fluid = TRUE
    )
  )
    , tabPanel(
      title = 'Shopping'
      , tableOutput('shopping_list')
    )
    , fluid = TRUE
)
server <- function(input, output, session) {
  
  output$date0 <- renderText({
    paste0(format(input$in_startdate, '%m/%d/%y'), ' - (', weekdays(input$in_startdate), ')')
  })
  
  output$date1 <- renderText({
    paste0(format(input$in_startdate + 1, '%m/%d/%y'), ' - (', weekdays(input$in_startdate + 1), ')')
  })
  
  output$date2 <- renderText({
    paste0(format(input$in_startdate + 2, '%m/%d/%y'), ' - (', weekdays(input$in_startdate + 2), ')')
  })
  
  output$date3 <- renderText({
    paste0(format(input$in_startdate + 3, '%m/%d/%y'), ' - (', weekdays(input$in_startdate + 3), ')')
  })
  
  output$date4 <- renderText({
    paste0(format(input$in_startdate + 4, '%m/%d/%y'), ' - (', weekdays(input$in_startdate + 4), ')')
  })
  
  output$date5 <- renderText({
    paste0(format(input$in_startdate + 5, '%m/%d/%y'), ' - (', weekdays(input$in_startdate + 5), ')')
  })
  
  output$date6 <- renderText({
    paste0(format(input$in_startdate + 6, '%m/%d/%y'), ' - (', weekdays(input$in_startdate + 6), ')')
  })
  
  output$shopping_list <- renderTable({
    tribble(
      ~Ingredient, ~Meal,
      'Test', 'Hopefully This Works'
    )
  })
  
}

shinyApp(ui = ui, server = server)
