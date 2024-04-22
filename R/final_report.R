finalreport <- function() {
  default_req("qcreport") |>
    httr2::req_headers(Authorization = get_key()) |>
    httr2::req_url_query(format = "json")
}
