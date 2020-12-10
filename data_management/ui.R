#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(shinyjs)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    useShinyjs(debug=T),
    # Input ----------------
    fluidRow(
        column(4, titlePanel("Data Management"),),
    ),
    #  Output ----------------
    tabsetPanel(id = "dataTypeChooser", type = "tabs",
                tabPanel(value  = "CSVPanel", id = "Timeline", strong("Upload CSV"),
                         mainPanel(
                             actionButton(
                                 "CsvButton",
                                 "Upload CSV files"
                             ),
                             actionButton(
                                 "DbButton",
                                 "Select From DB"
                             ),
                             actionButton(
                                 "RefreshButton",
                                 label = "",
                                 icon=icon("sync", class = "fa-1x", lib="font-awesome")
                             ),
                             textOutput("maintext")
                             #fileInput("fileMeta", "Choose Meta CSV File", accept = c("text/csv","text/comma-separated-values,text/plain",".csv")),
                             #fileInput("fileEvent", "Choose Event CSV File", accept = c("text/csv","text/comma-separated-values,text/plain",".csv")),
                             #fileInput("fileSample", "Choose Sample CSV File", accept = c("text/csv","text/comma-separated-values,text/plain",".csv")),
                             #actionButton("visButton", "Upload"),
                         ),
                ),
                # Rest of Page ---------------------------------------------------------------
                tags$footer()
    )
))