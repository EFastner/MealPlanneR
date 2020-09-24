library(tidyverse)

# Data source for meal list
list_entre <- 
  read_csv('data/meals.csv', col_names = TRUE, col_types = 'cc') %>%
  arrange(meal_name, meal_type)

# Function for creating Meal Inputs
f_dayplan_inputs <- function(date_offset, meal_type){
  # Description: Create the input format for each meal
  # can be called multiple times to quickly create all of
  # the needed inputs
  # 
  # Args
  # date_offset - Integer between 0 and 6 denoting day offset to start
  # meal_type - Integer 1 (breakfast), 2 (lunch), or 3 (dinner)
  
  meal_var <- 
    case_when(
      meal_type == 1 ~ 'breakfast'
      , meal_type == 2 ~ 'lunch'
      , meal_type == 3 ~ 'dinner'
    )
  
  # Filter List For Desired Meal
  meal_list <- 
    list_entre %>%
    filter(str_to_lower(meal_type) == meal_var) %>%
    select(meal_name) %>%
    add_row(meal_name = 'None')
  
  # Meal Choice
  fluidRow(
    column(3, 
           selectInput(
             inputId = paste0('in_', meal_var,'_choice', date_offset)
             , label = paste(str_to_title(meal_var), 'Meal')
             , choices = lapply(meal_list, str_to_sentence)
             , selected = 'None'
             , multiple = FALSE
             , selectize = TRUE
             , width = '100%'
           )
    )
    # Number of People
    , column(1,
             numericInput(
               inputId = paste0('in_', meal_var,'_count', date_offset)
               , label = 'People'
               , value = 0
               , min = 0
               , step = 1
             )
    )
    # Notes
    , column(8,
             textInput(
               inputId = paste0('in_', meal_var,'_notes', date_offset)
               , label = 'Notes:'
               , width = '100%'
             )
    )
  )
}