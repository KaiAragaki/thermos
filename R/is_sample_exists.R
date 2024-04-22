# Note: converts the reponse from a string to a boolean for convenience
is_sample_exists <- function(sample_name) {
  out <- default_req("isSampleExists") |>
    default_headers() |>
    httr2::req_method("POST") |>
    httr2::req_url_query(sampleName = sample_name) |>
    httr2::req_perform() |>
    httr2::resp_body_string()
  out == "true"
}
