# ShinyMap

This is a Shiny app to illustrate the API wrapper package developed in lab5. The app plots maps based on the selected dataset and date.

## Install package

The package has to be installed before running the Shiny app:

install.packages('devtools')

devtools::install_github("KarDeMumman/StreetMaps", subdir = "StreetMaps")

library(StreetMaps)

## Run App

shiny::runGitHub(repo="KarDeMumman/ShinyMap", subdir="MapViz")
