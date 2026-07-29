library(tidyverse)

build_noshow_model <- function(df) {
  if (!all(df$no_show_numeric %in% c(0, 1))) {
    stop("Validation Error: Outcome variable must be strictly binary (0 or 1).")
  }
  
  model <- glm(
    no_show_numeric ~ lead_time_days + age + sms_received + scholarship + hypertension,
    data = df,
    family = "binomial"
  )
  
  coef_df <- summary(model)$coefficients
  odds_ratios <- exp(coef(model))
  
  results_tbl <- tibble(
    Predictor = rownames(coef_df),
    Estimate = round(coef_df[, 1], 4),
    StdError = round(coef_df[, 2], 4),
    z_value = round(coef_df[, 3], 2),
    p_value = coef_df[, 4],
    OddsRatio = round(odds_ratios, 4)
  )
  
  return(list(model = model, table = results_tbl))
}
