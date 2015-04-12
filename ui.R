library(shiny)
library(plot3D)
library(rgl)


# Define UI for random distribution application 
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Tabsets"),
  
  # Sidebar with controls to select the random distribution type
  # and number of observations to generate. Note the use of the br()
  # element to introduce extra vertical spacing
  sidebarPanel(
    radioButtons("distance_type", "Minkowski Distance:",
                 list("Manhattan" = "man",
                      "Euclidean" = "euc",
                      "Maximum" = "max")),
    br(),
    #numericInput("rows", "R", 10),
    #numericInput("cols", "C", 10)
    
    sliderInput("rows", "Number of rows:",value = 5, min = 1, max = 10),
    sliderInput("cols", "Number of columns", value=5,min=1,max=10)
  ),
  
  # Show a tabset that includes a plot, summary, and table view
  # of the generated distribution
  mainPanel(
    tabsetPanel(
      tabPanel("Table", tableOutput("table")),
      tabPanel("Summary", tableOutput("summary")),
      tabPanel("Plot", plotOutput("plot")),
      tabPanel("Distance", tableOutput("distance"))
    )
  )
))