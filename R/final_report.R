finalreport <- function(type = c("sample", "analysis"),
                        name,
                        id = NULL,
                        start_date = NULL,
                        end_date = NULL,
                        view = NULL) {
  type <- rlang::arg_match(type)
  default_req("finalreport") |>
    default_headers() |>
    httr2::req_url_query(
      format = "json",
      type = type,
      name = name,
      id = id,
      start_date = start_date,
      end_date = end_date,
    ) |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}
