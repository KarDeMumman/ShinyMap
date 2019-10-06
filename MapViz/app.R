#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(httr)
library(jsonlite)
library(leaflet)
library(StreetMaps)


# Define UI for application that vizualizes a map
ui <- fluidPage(

    # Application title
    titlePanel("Map Vizualization"),

    # Sidebar with a dropdown list input for dataset
    sidebarLayout(
        sidebarPanel(
            selectInput("dataset", "Dataset:",
                        c("Swedish municipalities" = "se-7",
                          "Swedish counties" = "se-4",
                          "Norwegian municipalities" = "no-7",
                          "Norwegian counties" = "no-4",
                          "Danish municipalities" = "dk-7",
                          "Finnish municipalities" = "fi-8",
                          "Swiss municipalities" = "ch-8",
                          "Greenland municipalities" = "gl-7",
                          "US states" = "us-4",
                          "World countries" = "world-2")
                        )
        ),

        # Show the map corresponding to the selected dataset
        mainPanel(
            leafletOutput("mymap")
        )
    )
)

# Define server logic required to vizualize a map
server <- function(input, output) {
    geojson <- reactive({
        result <- Maps_api(input$dataset)
        result$content
    })
    
    output$mymap <- renderLeaflet({
        #result <- Maps_api(input$dataset)
        map <- leaflet()
        map <- addTiles(map)
        #map <- setView(map, lng = 18.961619, lat = 58.298584, zoom = 4)
        #map <- addGeoJSON(map, result$content)
        map <- addGeoJSON(map, geojson())
        #map <- result$map
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
