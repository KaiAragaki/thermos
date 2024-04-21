#' Get BAM files associated with samples or analyses
#'
#' @param name character vector of either sample or analysis names
#' @param type character, either "sample" or "analysis"
#'
#' @details You can get a list of analysis names using the `list_analyses`
#'   function. It's unclear if there's a way to get a list of sample names from
#'   the API.
#'
#' @export
get_associated_bamfiles <- function(name, type = c("analysis", "sample")) {
  type <- rlang::arg_match(type)
  default_req("getAssociatedBamfiles") |>
    httr2::req_headers(
      `Content-Type` = "application/x-www-form-urlencoded",
      Authorization = get_key()
    ) |>
    httr2::req_url_query(name = name, type = type, .multi = "comma") |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}
