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
        # h2(tags$b(textOutput('date0'))),
        # f_dayplan_inputs(0, 1),
        # f_dayplan_inputs(0, 2),
        # f_dayplan_inputs(0, 3)
        # , h2(tags$b(textOutput('date1'))),
        # f_dayplan_inputs(1, 1),
        # f_dayplan_inputs(1, 2),
        # f_dayplan_inputs(1, 3),
        # h2(tags$b(textOutput('date2'))),
        # f_dayplan_inputs(2, 1),
        # f_dayplan_inputs(2, 2),
        # f_dayplan_inputs(2, 3),
        # h2(tags$b(textOutput('date3'))),
        # f_dayplan_inputs(3, 1),
        # f_dayplan_inputs(3, 2),
        # f_dayplan_inputs(3, 3),
        # h2(tags$b(textOutput('date4'))),
        # f_dayplan_inputs(4, 1),
        # f_dayplan_inputs(4, 2),
        # f_dayplan_inputs(4, 3),
        # h2(tags$b(textOutput('date5'))),
        # f_dayplan_inputs(5, 1),
        # f_dayplan_inputs(5, 2),
        # f_dayplan_inputs(5, 3),
        # h2(tags$b(textOutput('date6'))),
        # f_dayplan_inputs(6, 1),
        # f_dayplan_inputs(6, 2),
        # f_dayplan_inputs(6, 3)
        uiOutput('meal_inputs')
        , width = 10
      )
      , fluid = TRUE
    )
  )
  , tabPanel(
    title = 'Shopping'
    , tableOutput('meal_list')
  )
  , fluid = TRUE
)
server <- function(input, output, session) {
  
  output$meal_inputs <- renderUI({
    # Creates all of the inputs for each date and mealtime
    
    lapply(0:6, function(i){
      # Loop through each date and create date title/inputs
      
      date_offset <- input$in_startdate + i
      
      fluidPage(
        # Date for inputs
        fluidRow(
          column(12
                 , HTML(paste0('<h2>', input$in_startdate + i, '</h2>'))
          )
        )
        
        # Loop through all meals and create inputs
        , lapply(c('breakfast', 'lunch', 'dinner'), function(meal_var){
          
          # Filter on Meals
          meal_list <- 
            meal_list <- 
            list_entre %>%
            filter(str_to_lower(meal_type) == meal_var) %>%
            select(meal_name) %>%
            add_row(meal_name = 'None')
          
          fluidRow(
            
            # Meal Name Selector
            column(3
                   , selectInput(
                     inputId = paste0('in_', meal_var, '_choice_', date_offset)
                     , label = paste(str_to_title(meal_var), ' Meal')
                     , choices = meal_list
                     , selected = 'None'
                     , multiple = FALSE
                     , selectize = TRUE
                     , width = '100%'
                   )
            )
            
            # Number of People
            , column(1
                     , numericInput(
                       inputId = paste0('in_', meal_var, '_count', date_offset)
                       , label = 'People'
                       , value = 0
                       , min = 0
                       , step = 1
                     )
            )
            
            # Notes
            , column(8
                     , textInput(
                       inputId = paste0('in_', meal_var, '_notes', date_offset)
                       , label = 'Notes:'
                       , width = '100%'
                     )
            )
          )
        })
      )
    })
  })
  
  output$meal_list <- renderTable({
    tibble(
      meal = lapply(0:6, function(i){
        date_offset <- input$in_startdate + i
        
        input[[paste0('in_breakfast_choice_', date_offset)]]  
      })
    )
  })
  
}

shinyApp(ui = ui, server = server)
