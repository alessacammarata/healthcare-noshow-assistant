library(tidyverse)

explore_lead_time <- function(df, max_days = 60) {
  if (!"lead_time_days" %in% colnames(df)) {
    stop("Validation Error: Variable 'lead_time_days' missing from dataset.")
  }
  if (!is.numeric(df$lead_time_days)) {
    stop("Validation Error: Lead time variable must be numeric.")
  }
  
  stats <- df %>%
    summarise(
      mean_lead = round(mean(lead_time_days, na.rm = TRUE), 2),
      median_lead = median(lead_time_days, na.rm = TRUE),
      sd_lead = round(sd(lead_time_days, na.rm = TRUE), 2),
      iqr_lead = IQR(lead_time_days, na.rm = TRUE),
      min_lead = min(lead_time_days, na.rm = TRUE),
      max_lead = max(lead_time_days, na.rm = TRUE)
    )
  
  p <- df %>%
    filter(lead_time_days <= max_days) %>%
    ggplot(aes(x = lead_time_days)) +
    geom_histogram(binwidth = 2, fill = "#2b5c8f", color = "white", alpha = 0.85) +
    theme_minimal() +
    labs(
      title = "Distribution of Appointment Lead Time",
      subtitle = "Days between booking date and scheduled medical visit",
      x = "Lead Time (Days)",
      y = "Number of Appointments"
    )
  
  return(list(stats = stats, plot = p))
}
