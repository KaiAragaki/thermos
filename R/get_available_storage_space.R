get_available_storage_space <- function() {
  default_req("getAvailableStorageSpace") |>
    default_headers() |>
    httr2::req_method("POST") |>
    httr2::req_perform() |>
    httr2::resp_body_string() |>
    as.numeric()
}
