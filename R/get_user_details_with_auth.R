get_user_details_with_auth <- function() {
  default_req("getUserDetailsWithAuth") |>
    httr2::req_method("POST") |>
    httr2::req_headers(
      `Content-Type` = "application/x-www-form-urlencoded"
    ) |>
    httr2::req_url_query(auth = get_key()) |>
    httr2::req_perform()
}
