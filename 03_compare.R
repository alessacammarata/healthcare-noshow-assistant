library(tidyverse)

compare_sms_impact <- function(df) {
  if (!all(c("sms_received", "no_show_numeric") %in% colnames(df))) {
    stop("Validation Error: Required variables 'sms_received' or 'no_show_numeric' missing.")
  }
  
  unique_groups <- unique(df$sms_received)
  if (length(unique_groups) != 2) {
    stop("Validation Error: The grouping variable must contain exactly two groups.")
  }
  
  summary_table <- df %>%
    group_by(sms_received) %>%
    summarise(
      total_appointments = n(),
      no_shows = sum(no_show_numeric),
      no_show_rate = round(mean(no_show_numeric), 4)
    )
  
  test_result <- prop.test(summary_table$no_shows, summary_table$total_appointments)
  
  return(list(
    summary = summary_table,
    rate_diff = round(summary_table$no_show_rate[2] - summary_table$no_show_rate[1], 4),
    conf_int = round(test_result$conf.int, 4),
    p_value = test_result$p.value
  ))
}
