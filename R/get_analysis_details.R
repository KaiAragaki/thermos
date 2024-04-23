#' Get analysis details
#'
#' @param type character. Either "sample" (the default) or "analysis"
#' @param name character. See details.
#' @param id character. Optional. ID of analysis.
#' @param start_date,end_date character. Optional. YYYY-MM-DD format.
#' @param duration Optional. Parameter to filter the results by days/months.
#'   Valid value starts with "-" follow by a numeric value and ending with "d"
#'   or "m"
#' @param exclude Optional. Can be "reports", "unfilteredvariants",
#'   "filteredvariants", or NULL. If NULL (default), downloads all.
#' @param view Optional. Can be "summary", which will include a list of all
#'   analyses without links to the analyses (which can be faster to call)
#' @param tidy boolean. Ignored if `view` is NULL. Should the results be
#'   presented as a tidy `tibble`?
#'
#' @return A JSON-like list or, if `view = "summary"` and `tidy = TRUE`, a
#'   `tibble`.
#'
#' @export
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
