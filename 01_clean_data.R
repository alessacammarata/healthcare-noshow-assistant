library(tidyverse)
library(lubridate)

clean_noshow_data <- function(filepath) {
  if (!file.exists(filepath)) {
    stop("Validation Error: Data file does not exist at specified path.")
  }
  
  df <- read_csv(filepath, show_col_types = FALSE) %>%
    rename(
      patient_id = PatientId,
      appointment_id = AppointmentID,
      gender = Gender,
      scheduled_day = ScheduledDay,
      appointment_day = AppointmentDay,
      age = Age,
      neighbourhood = Neighbourhood,
      scholarship = Scholarship,
      hypertension = Hipertension,
      diabetes = Diabetes,
      alcoholism = Alcoholism,
      handicap = Handcap,
      sms_received = SMS_received,
      no_show = `No-show`
    ) %>%
    filter(age >= 0) %>%
    mutate(
      scheduled_date = as.Date(scheduled_day),
      appointment_date = as.Date(appointment_day),
      lead_time_days = as.numeric(appointment_date - scheduled_date),
      no_show_numeric = if_else(no_show == "Yes", 1, 0),
      day_of_week = wday(appointment_date, label = TRUE, abbr = TRUE)
    ) %>%
    filter(lead_time_days >= 0)
  
  return(df)
}