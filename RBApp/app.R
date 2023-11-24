# RBApp
library(shiny)
library(colourpicker)
library(dplyr)
library(tidyverse)
library(gapminder)
library(ggplot2)

# Gapminder Dataset loaded
gm <- read_csv("gapminder.csv")

# Define UI for application
ui <- fluidPage(
  # Application title
  titlePanel("Gapminder Dataset"),
  sidebarLayout(
    sidebarPanel(
      selectInput("countryInput", "Country", choices = levels(gapminder$country)),
      radioButtons("color", "Point color",
                   choices = c("blue", "red", "green", "black"))),

    mainPanel(imageOutput("image"),
      plotOutput("plot")
)
)
)

server <- function(input, output){
  output$plot <- renderPlot({
    gap_filter <- gm %>% filter(country == input$countryInput) %>% select(country, year, gdpPercap)
    ggplot(gap_filter, aes(x = year, y = gdpPercap)) + geom_point(color = input$color) + ggtitle("GDP Per Capita Per Year")
   })
  output$image <- renderImage({
    list(src = "www/Gapminder Header Image.png",
         width = "100%",
         height = 330)
  }, deleteFile = F)
}

# Run the application
shinyApp(ui = ui, server = server)
