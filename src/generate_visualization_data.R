#' Generate visualization data for the COVID-19 forecast
#' hub.
#'
#' This script generates ensemble summaries, all-models
#' summaries, and web text for the visualization webpage
#' using functions from hubhelpr.
#'
#' Usage:
#' Rscript src/generate_visualization_data.R \
#' --reference-date "2025-01-04" \
#' --base-hub-path "covid19-forecast-hub/" \
#' --hub-reports-path "."

parser <- argparser::arg_parser(
  "Generate visualization data for the COVID-19 forecast hub."
)
parser <- argparser::add_argument(
  parser,
  "--reference-date",
  type = "character",
  help = "The reference date for the forecast in YYYY-MM-DD format (ISO-8601)."
)
parser <- argparser::add_argument(
  parser,
  "--base-hub-path",
  type = "character",
  default = "covid19-forecast-hub/",
  help = "Path to the COVID-19 forecast hub directory."
)
parser <- argparser::add_argument(
  parser,
  "--hub-reports-path",
  type = "character",
  default = ".",
  help = "Path to the hub reports directory."
)

args <- argparser::parse_args(parser)
ref_date <- args$reference_date
base_hub_path <- args$base_hub_path
hub_reports_path <- args$hub_reports_path
disease <- "covid"
horizons <- c(0, 1, 2)

pop_data <- readr::read_csv(
  fs::path(base_hub_path, "auxiliary-data", "locations_with_2023_census_pop.csv"),
  show_col_types = FALSE
) |>
  dplyr::select(location, population)

# generate ensemble summary
hubhelpr::write_ref_date_summary_ens(
  reference_date = ref_date,
  base_hub_path = base_hub_path,
  hub_reports_path = hub_reports_path,
  disease = disease,
  horizons_to_include = horizons,
  population_data = pop_data,
  targets = "wk inc covid hosp"
)

# generate all models summary
hubhelpr::write_ref_date_summary_all(
  reference_date = ref_date,
  base_hub_path = base_hub_path,
  hub_reports_path = hub_reports_path,
  disease = disease,
  horizons_to_include = horizons,
  population_data = pop_data,
  targets = "wk inc covid hosp"
)

# generate web text
hubhelpr::write_webtext(
  reference_date = ref_date,
  disease = disease,
  base_hub_path = base_hub_path,
  hub_reports_path = hub_reports_path
)
