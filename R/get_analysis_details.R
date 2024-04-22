analysis <- function(type = c("sample", "analysis"),
                     name = NULL,
                     id = NULL,
                     start_date = NULL,
                     end_date = NULL,
                     duration = NULL,
                     exclude = NULL,
                     view = NULL,
                     tidy = TRUE) {
  type <- rlang::arg_match(type)
  view <- ifelse(is.null(view), "", view)
  out <- default_req("analysis") |>
    default_headers() |>
    httr2::req_url_query(
      format = "json", type = type, name = name, id = id,
      start_date = start_date, end_date = end_date, duration = duration,
      exclude = exclude, view = view
    ) |>
    httr2::req_perform() |>
    httr2::resp_body_json()
  if (tidy && view == "summary") {
    out <- out |>
      lapply(\(x) {
        x |>
          tibble::enframe() |>
          tidyr::pivot_wider()
      }
      ) |>
      dplyr::bind_rows() |>
      tidyr::unnest(cols = dplyr::everything(), keep_empty = TRUE) |>
      tidyr::unnest(cols = dplyr::everything(), keep_empty = TRUE)
  }
  out
}
