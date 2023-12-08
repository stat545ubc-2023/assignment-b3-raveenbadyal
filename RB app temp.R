# RBApp
# Any packages used were loaded below:
library(shiny)
library(colourpicker)
library(dplyr)
library(ggplot2)

# Gapminder Dataset loaded
# install.packages('gapminder')
library(gapminder)

# Define UI for application
ui <- fluidPage(
  # Application title
  titlePanel("Gapminder Dataset"),
  # There are two features used here with the sidebarLayout() function. First,
  # the interactive plot uses an input for country from the user. This would allow the user
  # to easily compare the change in GDP per year among different countries. Being able to
  # change the colour of the points of the plot is for the aesthetics and a part of the
  # experience for the user.
  sidebarLayout(
    sidebarPanel(
      selectInput("countryInput", "Country", choices = levels(gapminder$country)),
      radioButtons("color", "Point color",
                   choices = c("blue", "red", "green", "black"))),
    imageOutput("image")),
  # The third feature used was adding an image. I was able to find some word art of the word
  # "Gapminder" to add colour and a different font to the app. This was also done for aesthetics,
  # as a background for the webpage.

  # The fourth feature is adding tabs for the plot to be displayed separately from the table.
  # The fifth feature was to include a table output to supplement the plot output.
  mainPanel(
    tabsetPanel(
      tabPanel("Plot", plotOutput("plot")),
      tabPanel("Table", tableOutput("table")))
  ))


server <- function(input, output){
  output$plot <- renderPlot({
    gap_filter <- gapminder %>% filter(country == input$countryInput) %>% select(country, year, gdpPercap)
    ggplot(gap_filter, aes(x = year, y = gdpPercap)) + geom_point(color = input$color) + ggtitle("GDP Per Capita Per Year")
  })
  output$table <- renderTable({
    gap_filter <- gapminder %>% filter(country == input$countryInput) %>%
      select(country, year, gdpPercap)
  })
  output$image <- renderImage({
    list(src = "www/Gapminder Header Image.png",
         width = "100%",
         height = 330)
  }, deleteFile = F)
}


# Run the application
shinyApp(ui = ui, server = server)
