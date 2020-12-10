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
    #df_csv <- callModule(csv_upload, "uploadData")
    df <- reactive({ callModule(db_select, "selectData") })
    
    output$maintext <- renderText({
        paste(names(df()))
    })
    
    observeEvent(input$CsvButton, {
        insertUI(selector = "#CsvButton", where = "afterEnd",
                 ui = showModal(modalDialog(csv_upload_UI("uploadData"), easyClose = TRUE)))
    })
    observeEvent(input$DbButton, {
        insertUI(selector = "#DbButton", where = "afterEnd",
                 ui = showModal(modalDialog(db_select_UI("selectData"), easyClose = TRUE)))
    })
    
})
