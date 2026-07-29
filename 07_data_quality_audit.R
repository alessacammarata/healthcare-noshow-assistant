library(tidyverse)

audit_data_quality <- function(filepath) {
  df_raw <- read_csv(filepath, show_col_types = FALSE)
  
  missing_summary <- colSums(is.na(df_raw))
  neg_ages <- sum(df_raw$Age < 0, na.rm = TRUE)
  invalid_dates <- sum(as.Date(df_raw$AppointmentDay) < as.Date(df_raw$ScheduledDay), na.rm = TRUE)
  dup_rows <- sum(duplicated(df_raw))
  
  audit_tbl <- tibble(
    Check = c("Total Records", "Missing Values Count", "Negative Age Records", "Invalid Date Sequence Records", "Duplicate Rows"),
    Result = c(nrow(df_raw), sum(missing_summary), neg_ages, invalid_dates, dup_rows)
  )
  
  return(audit_tbl)
}
