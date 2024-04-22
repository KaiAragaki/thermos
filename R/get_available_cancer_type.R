get_available_cancer_type <- function() {
  out <- default_req("getAvailableCancerType") |>
    default_headers() |>
    httr2::req_method("POST") |>
    httr2::req_perform() |>
    httr2::resp_body_string()

  as_vec <- out |>
    strsplit("\\\",\\\"") |>
    unlist() |>
    stringr::str_remove("\\\"]") |>
    stringr::str_remove("\\[\\\"")

  as_vec
}
