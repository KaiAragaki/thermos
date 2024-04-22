get_user_details_with_auth <- function(auth = NULL) {
  if (is.null(auth)) {
    auth <- get_key()
  }
  default_req("getUserDetailsWithAuth") |>
    httr2::req_method("POST") |>
    httr2::req_headers(
      `Content-Type` = "application/x-www-form-urlencoded"
    ) |>
    httr2::req_url_query(auth = auth) |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}

get_user_details <- function(user_name, password) {
  default_req("getUserDetails") |>
    httr2::req_method("POST") |>
    httr2::req_headers(
      `Content-Type` = "application/x-www-form-urlencoded"
    ) |>
    httr2::req_url_query(userName = user_name, password = password) |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}
