get_vcf <- function(type = c("sample", "analysis"),
                    name = NULL,
                    id = NULL,
                    start_date = NULL,
                    end_date = NULL,
                    duration = NULL,
                    exclude = NULL) {
  type <- rlang::arg_match(type)
  end <- "https://ionreporter.thermofisher.com/api/v1/getvcf"
  out <- httr2::request(end) |>
    httr2::req_headers(
      `Content-Type` = "application/x-www-form-urlencoded",
      Authorization = get_key()
    ) |>
    httr2::req_url_query(
      format = "json", type = type, name = name, id = id,
      start_date = start_date, end_date = end_date, duration = duration,
      exclude = exclude
    )
  out |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}