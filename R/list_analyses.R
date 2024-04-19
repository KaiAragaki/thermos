list_analyses <- function(tidy = TRUE) {
  end <- "https://ionreporter.thermofisher.com/api/v1/analysis"
  out <- httr2::request(end) |>
    httr2::req_headers(
      `Content-Type` = "application/x-www-form-urlencoded",
      Authorization = get_key()
    ) |>
    httr2::req_url_query(format = "json", view = "summary") |>
    httr2::req_perform() |>
    httr2::resp_body_json()
  if (tidy) {
    out <- out |>
      lapply(\(x) tibble::enframe(x) |> tidyr::pivot_wider()) |>
      dplyr::bind_rows() |>
      tidyr::unnest(cols = dplyr::everything(), keep_empty = TRUE) |>
      tidyr::unnest(cols = dplyr::everything(), keep_empty = TRUE)
  }
  out
}
