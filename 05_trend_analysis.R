library(tidyverse)

analyze_day_of_week_trend <- function(df) {
  if (!"day_of_week" %in% colnames(df)) {
    stop("Validation Error: Variable 'day_of_week' is missing.")
  }
  
  trend_summary <- df %>%
    group_by(day_of_week) %>%
    summarise(
      total_volume = n(),
      no_shows = sum(no_show_numeric),
      no_show_rate = round(mean(no_show_numeric), 4)
    )
  
  p <- ggplot(trend_summary, aes(x = day_of_week, y = no_show_rate, group = 1)) +
    geom_line(color = "#d95f02", size = 1.2) +
    geom_point(size = 3.5, color = "#d95f02") +
    scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
    theme_minimal() +
    labs(
      title = "No-Show Rate Trend Across Days of the Week",
      x = "Day of Week",
      y = "No-Show Rate (%)"
    )
  
  return(list(summary = trend_summary, plot = p))
}
