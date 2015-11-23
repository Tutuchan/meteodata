library(shinydashboard)
library(shiny)


header <- dashboardHeader(title = "France meteo")
sidebar <- dashboardSidebar()
body <- dashboardBody(
  fluidRow(
    box(leafletOutput("temperatureMap"),
        h3("Source: Météo-France"),
        width = 12,
        title = "Temperature")
  )
  
)

dashboardPage(
  header,
  sidebar,
  body
)
