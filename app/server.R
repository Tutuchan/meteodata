library(shinydashboard)
library(shiny)
source("global.R")

shinyServer(function(input, output, session) {
  output$textTest <- renderPrint({
    # spPolygons@data$insee[input$mainMap_shape_click$id]-100
  })
  
  output$temperatureMap <- renderLeaflet({
    leaflet(spStations) %>% 
      addTiles() %>% 
      addProviderTiles("Acetate.terrain") %>% 
      addCircles(popup = ~Nom, color = ~pal(-mean_temp), weight = 10, opacity = 1)
  })
})
