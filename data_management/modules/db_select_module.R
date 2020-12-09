df_meta = NULL

db_select_UI <- function(id) {
  ns = NS(id)
  list(
    fluidPage(
    HTML("<h3>Select and Edit Data</h3>",
         "<p>Here you can switch which data record is being used,
         remove records and upload new records.</p>"),
    textOutput(ns("statusText")),
    uiOutput(ns("sessionList"))
    )
  )
}

db_select <- function(input, output, session) {
  ns <- session$ns
  
  if (is.null(df_meta)) {
    auth <- read.csv("credentials.csv", header=TRUE,sep=",", colClasses=c("character","character","character","character"))
    ConnectToServer(auth)
    meta <- unique(RetreiveAllData("Meta"))
    active <- as.character(meta$SessionID[1])
    SetSessionID(active)
    full <- RetreiveCurrentData()
    df_meta <- reactive(meta)
    df <- reactive(full)
  }
  
  observeEvent(df_meta(), {
    has_data = !is.null(df_meta)
    if (has_data) {
      ids <- df_meta()$SessionID
      timestamps <- df_meta()$Timestamp
      emails <- df_meta()$Email
      output$statusText <- renderText({ paste(length(ids), "sessions available.") })
      output$sessionList <- renderUI({
        lapply(1:length(ids), function(i) {
          db_session_row_UI(ns(i))
        })
      })
      lapply(1:length(ids), function(i) {
        # Note to self: use ns(i) for UI functions.
        # But don't use ns(i) for callModule functions.
        callModule(db_session_row, i, active, ids[i], emails[i], timestamps[i])
      })
    }
  })
  
  return (df)
}