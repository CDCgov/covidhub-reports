# Forecast Visualization Data (V2)

The following data

* are generated partially from [COVID](https://github.com/CDCgov/covid19-forecast-hub/tree/main/model-output) and [RSV](https://github.com/CDCgov/rsv-forecast-hub/tree/main/model-output) Hub submission.
* are generated partially from [NHSN hospital respiratory data](https://www.cdc.gov/nhsn/psc/hospital-respiratory-reporting.html) and [NSSP Emergency Department Visits data](https://data.cdc.gov/Public-Health-Surveillance/NSSP-Emergency-Department-Visit-Trajectories-by-St/rdmq-nq56/about_data).
* are used for public forecast visualization.
* follows a particular schema, outlined below.

__Map Component__ (`YYYY-MM-DD_{disease}_map_data.csv`)

_Contains data from the ensemble COVID or RSV forecast for all states (including US, DC and Puerto Rico) and for 7 and 14 day forecast targets_


* `location_name` (string): state name column. Includes US (Ex: Alabama)
* `model` (string): the ensemble model name (Ex: CovidHub-ensemble)
* `quantile_0.025_per100k` (numeric): 0.025 quantile forecast value as a rate per 100k (Ex: 1.12777351608532)
* `quantile_0.5_per100k` (numeric) 0.5 quantile forecast value as a rate per 100k
* `quantile_0.975_per100k` (numeric) 0.975 quantile forecast value as a rate per 100k
* `quantile_0.025_count` (numeric): 0.025 quantile forecast value (Ex: 3754.07763671875)
* `quantile_0.5_count` (numeric) 0.5 quantile forecast value
* `quantile_0.975_count` (numeric) 0.975 quantile forecast value
* `quantile_0.025_per100k_rounded` (numeric): forecasted value as a rate per 100k, rounded to 2 places (Ex: 3.57)
* `quantile_0.5_per100k_rounded` (numeric): forecasted value as a rate per 100k, rounded to 2 places
* `quantile_0.975_per100k_rounded` (numeric): forecasted value as a rate per 100k, rounded to 2 places
* `quantile_0.025_count_rounded` (numeric): 0.025 quantile forecast value, rounded up to the nearest integer (Ex: 3755)
* `quantile_0.5_count_rounded` (numeric) 0.5 quantile forecast value, rounded up to the nearest integer
* `quantile_0.975_count_rounded` (numeric) 0.975 quantile forecast value, rounded up to the nearest integer
* `target` (string): description of forecast target date (Ex: 7 day ahead inc hosp)
* `target_end_date` (date): target date for the forecast (Ex: 2024-11-30)
* `reference_date` (date): date that the forecast was generated (Ex: 2024-11-23)
* `target_end_date_formatted` (string): target date for the forecast, prettily re-formatted as a string (Ex: “November 30, 2024”)
* `reference_date_formatted` (string): date that the forecast was generated, prettily re-formatted as a string (Ex: “November 23, 2024”)

__Timeseries Component__ (`YYYY-MM-DD_{disease}_forecasts_data.csv`):

_Contains all the available COVID or RSV models submitted in a given week for all states (including US, DC and Puerto Rico)._

* `location_name` (string): full state name for the forecast` (note: US is not spelled out) (Ex: Alabama, US)
* `abbreviation` (string): abbreviated state name (Ex: AL)
* `horizon` (numeric): time horizon for the forecast. Currently using time horizons 0, 1, 2, 3 (Ex: 2)
* `forecast_date` (date): date that forecast was generated (Ex: 2024-11-23)
* `target_end_date` (date): target date for forecast (Ex: 2024-11-30)
* `target` (string): **[NEW]** description of forecast target (Ex: "wk inc {disease} hosp")
* `model` (string): name of the model, pulled from the folder names in the model-output section of the forecast repos (Ex: FluSight-ensemble, CEPH-Rtrend_fluH)
* `quantile_0.025` (numeric): 0.025 quantile forecast value (Ex: 922.475)
* `quantile_0.25` (numeric): 0.25 quantile forecast value
* `quantile_0.5` (numeric): 0.5 quantile forecast value
* `quantile_0.75` (numeric): 0.75 quantile forecast value
* `quantile_0.975` (numeric): 0.975 quantile forecast value
* `quantile_0.025_rounded` (numeric): 0.025 quantile forecast value, rounded up to the nearest integer (Ex: 923)
* `quantile_0.25_rounded` (numeric): 0.25 quantile forecast value, rounded up to the nearest integer
* `quantile_0.5_rounded` (numeric): 0.5 quantile forecast value, rounded up to the nearest integer
* `quantile_0.75_rounded` (numeric): 0.75 quantile forecast value, rounded up to the nearest integer
* `quantile_0.975_rounded` (numeric): 0.975 quantile forecast value, rounded up to the nearest integer
* `forecast_teams` (string): name of the team that generated the model; pulled from model metadata (Ex: CEPH Lab at Indiana University)
* `forecast_fullnames` (string): full name of the model; pulled from model metadata (Ex: Rtrend COVID)

__Truth Data__ (`YYYY-MM-DD_{disease}_target_data.csv`)

_Contains the most recent observed COVID or RSV hospitalization and proportion of ED visits data for all states (including US, DC and Puerto Rico) but not including the remainder of the territories._

* `week_ending_date` (date): week ending date of observed data per row (Ex: 2024-11-16)
* `location` (string): two-digit FIPS code associated with each state (Ex: 06)
* `location_name` (string): spelled out state name` (note: US is not spelled out) (Ex: California, US)
* `target` (string): **[NEW]** description of the truth data target (Ex: "wk inc {disease} hosp")
* `value` (numeric): number of hospital admissions or proportion of ED visits; Hospital admissions should be an integer (Ex: 3); proportion of ED visits should be of form 0.**

__Webtext data__ (`YYYY-MM-DD_{disease}_webtext.md`)

_Contains texts populating the public forecast pages._

- The {hub_name} ensemble's one-week-ahead forecast predicts that {target_description} will be approximately {forecast_value}{value_unit} nationally, with {lower_value}{value_unit} to {upper_value}{value_unit} likely reported in the week ending {target_end_date_1wk_ahead}.

- This is compared to the {last_reported}{value_unit} reported for the week ending {last_reported_target_data$week_end_date_formatted}, the most recent week of {data_source}. Reported and forecasted {target_short} as of {forecast_due_date}.

- The figure shows {target_description} reported in the United States each week from {first_target_data_date} through {last_target_data_date} and forecasted {target_short} per week for this week and the next 2 weeks through {target_end_date_2wk_ahead}.

- Reporting rate flag (only for hospital admissions target).

-	[List of contributing teams and models as hyperlinks to the sites provided in the metadata].
