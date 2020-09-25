library(shiny)
library(tidyverse)
library(lubridate)

source('R/initialize.R')

ui <- navbarPage(
  title = 'MealPlanneR'
#----------------------Page 1, Plan Meals-------------------------  
  , tabPanel(
    title = 'Plan Meals'
    ,
    sidebarLayout(
      sidebarPanel(
        #----------------------Sidebar Welcome-------------------------
        p(HTML('<b>Welcome to MealPlanneR!<br>Start by Making Your Selections Below</b>'), align = 'center')
        #----------------------Date Input-------------------------
        , dateRangeInput(
          inputId = 'in_DateRange'
          , label = 'Dates to Plan'
          , start = today() + 1
          , end = today() + 6
          , max = today() + 30
          , format = 'm/d/yyyy'
        )
        #----------------------Which Meals to Plan-------------------------
        , checkboxGroupInput(
          inputId = 'in_meal_to_plan'
          , label = 'Which Meals to Plan?'
          , choices = c('Breakfast', 'Lunch', 'Dinner')
          , selected = c('Breakfast', 'Lunch', 'Dinner')
          , inline = TRUE
        )
        , width = 2
      ),
      mainPanel(
        uiOutput('meal_inputs')
        , width = 10
      )
      , fluid = TRUE
    )
  )
#----------------------Page 2, Shopping List-------------------------  
  , tabPanel(
    title = 'Shopping'
    , h1('IN PROGRESS')
  )
  , fluid = TRUE
)

server <- function(input, output, session) {
  
  output$meal_inputs <- renderUI({
    # Creates all of the inputs for each date and mealtime
    
    plan_days <- 
      input$in_DateRange[[2]] - input$in_DateRange[[1]]
    
    lapply(0:plan_days, function(i){
      # Loop through each date and create date title/inputs
      
      date_offset <- input$in_DateRange[[1]]
      
      fluidPage(
        # Date for inputs
        fluidRow(
          column(12
                 , HTML(paste0('<h2>', input$in_DateRange[[1]] + i, '</h2>'))
          )
        )
        
        # Loop through all meals and create inputs
        , lapply(str_to_lower(input$in_meal_to_plan), function(meal_var){
          
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
  
}

shinyApp(ui = ui, server = server)
