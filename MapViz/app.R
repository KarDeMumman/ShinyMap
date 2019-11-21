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
                          "Danish municipalities" = "dk-7",
                          "Finnish municipalities" = "fi-8",
                          "Swiss municipalities" = "ch-8",
                          "Greenland municipalities" = "gl-7",
                          "US states" = "us-4",
                          "World countries" = "world-2")
                        ),
            selectInput("year", "Year:",
                       c("2010" = 2010,
                         "2011" = 2011,
                         "2012" = 2012,
                         "2013" = 2013,
                         "2014" = 2014,
                         "2015" = 2015,
                         "2016" = 2016,
                         "2017" = 2017,
                         "2018" = 2018,
                         "2019" = 2019)
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
    getspdata <- reactive({
        result <- Maps_api(input$dataset, input$year)
        result$spdata
    })
    
    output$mymap <- renderLeaflet({
        map <- leaflet()
        map <- addTiles(map)
        #map <- setView(map, lng = 18.961619, lat = 58.298584, zoom = 2)
        map <- addPolygons(map, data = getspdata())
        
        #result <- Maps_api(input$dataset)
        #map <- addGeoJSON(map, result$content)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
