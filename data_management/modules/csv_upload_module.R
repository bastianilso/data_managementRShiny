csv_upload_df = NULL
csv_upload_UI <- function(id) {
  ns = NS(id)
  list(
    HTML("<h3>CSV File Upload</h3>",
         "<p>Please add three files in here, which represent the
         <strong>Event</strong>, <strong>Meta</strong> or <strong>Sample</strong>
         CSV files.</p>"),
    fileInput(
      ns("fileMeta"),
      "Choose Meta CSV File", accept = c("text/csv","text/comma-separated-values,text/plain",".csv")),
    fileInput(
      ns("fileEvent"),
      "Choose Event CSV File", accept = c("text/csv","text/comma-separated-values,text/plain",".csv")),
    fileInput(
      ns("fileSample"),
      "Choose Sample CSV File", accept = c("text/csv","text/comma-separated-values,text/plain",".csv")),
    textOutput(ns("statusText"))
  )
}
csv_upload <- function(input, output, session) {
  ns <- session$ns
  csv_upload_df <<- reactive ({
    load_files <- !is.null(input$fileMeta) && !is.null(input$fileEvent) &&
      !is.null(input$fileSample)
    if (load_files) {
      LoadFromFilePaths(input$fileMeta$datapath, input$fileEvent$datapath, input$fileSample$datapath)
    } else {
      NULL
    }
  })
  
  observeEvent(csv_upload_df(), {
    has_data = !is.null(csv_upload_df)
    if (has_data) {
      output$statusText <- renderText({ " Data Received Successfully!" })
    insertUI(selector = paste0("#", ns("statusText")), where="afterBegin",
            ui = icon("check", class = "fa-1x", lib="font-awesome"))
    }
  })
}

GetCSVUploadDf <- function() {
  return(csv_upload_df)
}