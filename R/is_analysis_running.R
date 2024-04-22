is_analysis_running <- function(user_id) {
  default_req("isAnalysisRunning") |>
    default_headers() |>
    httr2::req_method("POST") |>
    httr2::req_url_query(userId = user_id) |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}
