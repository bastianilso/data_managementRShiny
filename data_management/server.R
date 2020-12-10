#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    connected = GetConnectedToServer()
    if (!connected) {
        auth <- read.csv("credentials.csv", header=TRUE,sep=",", colClasses=c("character","character","character","character"))
        connected = ConnectToServer(auth)
    }
    
    callModule(db_select, "selectData", connected)
    callModule(csv_upload, "uploadData")
    r <- reactiveValues(choice = 'db',
                        df = NULL,
                        df_db = RetreiveCurrentData(),
                        df_csv = GetCSVUploadDf())
    
    observeEvent(input$CsvButton, {
        insertUI(selector = "#CsvButton", where = "afterEnd",
                 ui = showModal(modalDialog(csv_upload_UI("uploadData"), easyClose = TRUE)))
        r$choice <- 'csv'
    })
    observeEvent(input$DbButton, {
        insertUI(selector = "#DbButton", where = "afterEnd",
                 ui = showModal(modalDialog(db_select_UI("selectData"), easyClose = TRUE)))
        r$choice <- 'db'
    })
    observeEvent(input$RefreshButton, {
        if (r$choice == 'db') { #is.null(r$df_csv())
            r$df <- RetreiveCurrentData()
        } else if (r$choice == 'csv') {
            r$df <- GetCSVUploadDf()()
        }
    })

    output$maintext <- renderText({
        req(!is.null(r$df))
        paste(names(r$df))
    })
    
})
