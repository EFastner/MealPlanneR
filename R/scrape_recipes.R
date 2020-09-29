library(rvest)
library(tidyverse)

scrape_allrecipes <- function(url){
  
  raw_website <- 
    read_html(url)
  
  title <- 
    raw_website %>%
    html_nodes('h1.headline.heading-content') %>%
    html_text() %>%
    str_remove_all('\n|:') %>%
    str_trim()
  
  recipe_meta <- 
    tibble(
      meta =
        raw_website %>%
        html_nodes('.recipe-meta-item-header') %>%
        html_text() %>%
        append('title', after = 0) %>%
        str_to_lower() %>%
        str_remove_all('\n|:') %>%
        str_trim()
      ,
      values =
        raw_website %>%
        html_nodes('.recipe-meta-item-body') %>%
        html_text() %>%
        append(title, after = 0) %>%
        str_remove_all('\n|:') %>%
        str_trim()
    ) %>%
    pivot_wider(names_from = meta, values_from = values)
  
  
  ingredients <- 
    raw_website %>%
    html_nodes('.ingredients-item [class="ingredients-item-name"]') %>%
    html_text() %>%
    str_remove_all('\n|:') %>%
    str_trim()
  
  directions <- 
    tibble(
      step = 
        raw_website %>%
        html_nodes('.checkbox-list-text') %>%
        html_text() %>%
        str_remove_all('\n|[Step]') %>%
        str_trim()
      ,
      text =
        raw_website %>%
        html_nodes('.section-body .paragraph p') %>%
        html_text()  
    )
  
  return(list('meta' = recipe_meta, 'ingredients' = ingredients, 'directions' = directions))
  
}
