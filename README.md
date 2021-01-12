# Data Management for R Shiny
This repository provides a modules to handle and show data from CSV files and Databases for R Shiny Applications. It is specifically designed for the logs produced by [LoggingManager](https://github.com/med-material/LoggingManager). It consists of the following modules:

 * csv_upload_module: This module provides UI and functionality to upload CSV files.
 * db_select_module: This module provides UI and functionality for listing available log files in a database.
 * data_selection_summary_module: This module shows a summary of the current dataset in use.
 * db_session_row_module: sub-module for db_select_module.

## User Interface
![image](https://user-images.githubusercontent.com/3967945/104312130-7950b900-54d6-11eb-8edd-eed76fccd7f9.png)
The application provides a minimal example user interface. CSV Upload and DB Select are shown as modal dialogs from two buttons. Data selection summary is shown as HTML output next to the buttons.

## CSV Upload Module
![image](https://user-images.githubusercontent.com/3967945/104311862-1ced9980-54d6-11eb-8411-a79b52917861.png)

## DB Select Module
![image](https://user-images.githubusercontent.com/3967945/104312093-6b9b3380-54d6-11eb-820f-d1567d64076b.png)

