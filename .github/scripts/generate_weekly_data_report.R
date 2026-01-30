parser <- argparser::arg_parser(
  "Generate visualization data for a forecast hub."
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
  help = "Path to the forecast hub directory."
)
parser <- argparser::add_argument(
  parser,
  "--hub-reports-path",
  type = "character",
  default = ".",
  help = "Path to the hub reports directory."
)
parser <- argparser::add_argument(
  parser,
  "--disease",
  type = "character",
  help = "Disease name (e.g., 'covid' or 'rsv')."
)


args <- argparser::parse_args(parser)
ref_date <- as.Date(args$reference_date)
base_hub_path <- args$base_hub_path
hub_reports_path <- args$hub_reports_path
disease <- args$disease


hubhelpr::write_ref_date_summary_ens(
  reference_date = ref_date,
  base_hub_path = base_hub_path,
  hub_reports_path = hub_reports_path,
  disease = disease
)

hubhelpr::write_ref_date_summary_all(
  reference_date = ref_date,
  base_hub_path = base_hub_path,
  hub_reports_path = hub_reports_path,
  disease = disease
)

hubhelpr::write_viz_target_data(
  reference_date = ref_date,
  base_hub_path = base_hub_path,
  hub_reports_path = hub_reports_path,
  as_of = ref_date - lubridate::days(3),
  disease = disease
)
