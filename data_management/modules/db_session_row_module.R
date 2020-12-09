library(lubridate)
library(shinyjs)
db_session_row_UI <- function(id) {
  ns = NS(id)
  list(
    fluidRow(id=ns("row"),
      column(8, uiOutput(ns("sessionText"))),
      column(2, actionButton(ns("actionDelete"), "Delete")),
      column(2, actionButton(ns("actionChoose"), "Choose"))
    )
  )
}

db_session_row <- function(input, output, session, chosenid = NULL, sesid, email, timestamp) {
  ns <- session$ns
  UpdateText(input, output, session, chosenid, sesid, email, timestamp)
  
  observeEvent(input$actionDelete, {
    UpdateText(input, output, session, chosenid, sesid, email, timestamp,markForDeletion=TRUE)
    MarkDataForDeletion("hammel_dec2020_meta_2","SessionID",sesid)
  })
  
}

UpdateText <- function(input, output, session, chosenid = NULL, sesid, email, timestamp,markForDeletion=F) {
  time <- sprintf("%02d:%02d", hour(timestamp), minute(timestamp))
  weekday <- wday(timestamp, abbr = F, label=T)
  thedate <- format(date(timestamp), "%d %b %Y")
  timestring <- paste(weekday, thedate,time)
  theid <- str_sub(sesid,-6,-1)
  style = ""
  styletext = ""
  if (chosenid == sesid) {
    style = "class='bg-success'"
    styletext = " <strong>(Active)</strong>"
  }
  if (markForDeletion) {
    style = "class='bg-danger'"
    styletext = " <strong>(Marked For Deletion)</strong>"
  }
  output$sessionText <- renderUI({
    HTML(paste0("<p ",style,">",timestring,styletext,"<br><small>",email," (",theid,")</small></p>"))
  })
}