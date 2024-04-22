get_data_upload_path_with_auth <- function(auth = NULL) {
  if (is.null(auth)) {
    auth <- get_key()
  }
  default_req("getDataUploadPathWithAuth") |>
    httr2::req_method("POST") |>
    httr2::req_headers(
      `Content-Type` = "application/x-www-form-urlencoded"
    ) |>
    httr2::req_url_query(auth = auth) |>
    httr2::req_perform() |>
    httr2::resp_body_string()
}
