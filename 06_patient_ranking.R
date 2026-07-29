library(tidyverse)

rank_high_risk_patients <- function(df, model, top_n = 20) {
  required_vars <- c("lead_time_days", "age", "sms_received", "scholarship", "hypertension")
  if (!all(required_vars %in% colnames(df))) {
    stop("Validation Error: Input dataframe is missing required model predictor columns.")
  }
  
  df_scored <- df %>%
    mutate(predicted_risk = round(predict(model, newdata = df, type = "response"), 4)) %>%
    arrange(desc(predicted_risk)) %>%
    select(patient_id, appointment_id, appointment_date, age, lead_time_days, predicted_risk) %>%
    head(top_n)
  
  return(df_scored)
}
