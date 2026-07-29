# Patient Ranking Skill (High-Risk Priority Queue)

## Purpose
Which upcoming scheduled appointments carry the highest predicted probability of missing their visit, requiring immediate outreach from the Patient Care Coordinator?

## When to Use
Activate when the user requests a prioritized list, ranking, or daily outreach queue of high-risk patient appointments for intervention.

## Required Inputs
- Trained logistic regression model object.
- Dataset containing upcoming appointments with required predictor features (`lead_time_days`, `age`, `sms_received`, `scholarship`, `hypertension`).

## Files Used
- `R/01_clean_data.R`
- `R/04_model.R`
- `R/06_patient_ranking.R`

## Method
Predictive Risk Scoring and Composite Sorting ($P(\text{No-Show}) \ge \text{Threshold}$).

## Procedure
1. Fit or load the logistic regression model from `R/04_model.R`.
2. Generate individual predicted probabilities for every row using `predict(type = "response")`.
3. Call `rank_high_risk_patients(df, model, top_n = 20)` in `R/06_patient_ranking.R`.
4. Output a clean table listing the top 20 highest-risk scheduled appointments sorted by risk score.

## Validation
- Confirm model object is valid and trained.
- Validate that all required predictor columns exist in the input dataframe.
- If required predictors are missing, stop execution and display: "Validation Error: Input data is missing required feature columns for model scoring."

## Output
Top-N priority ranking table displaying `patient_id`, `appointment_id`, `appointment_date`, `lead_time_days`, `age`, and `predicted_risk_score`.

## Interpretation
"The top 20 appointments listed in this queue carry predicted no-show probabilities exceeding X%. Outreach resources (manual phone calls, transport vouchers) should be prioritized starting from Rank 1."

## Limitation
Probability scores represent statistical likelihood based on historical averages. High risk scores do not guarantee a no-show, so outreach should remain supportive rather than punitive.