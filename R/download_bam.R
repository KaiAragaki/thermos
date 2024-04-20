#' Download a BAM file
#'
#' In a typical workflow, this will be used with `get_associated_bamfiles` to
#' obtain the `file_path` argument
#'
#' @param file_path character. Typically the output of
#'   `get_associated_bamfiles`.
#' @param type character. Honestly no idea what this does. If NULL (default),
#'   downloads a zip. Other options are "" and "pdf"
#' @export
download_bam <- function(file_path, type = NULL) {
  type <- rlang::arg_match(type)
  end <- "https://ionreporter.thermofisher.com/api/v1/downloadBAM"
  httr2::request(end) |>
    httr2::req_headers(
      `Content-Type` = "application/x-www-form-urlencoded",
      Authorization = get_key()
    ) |>
    httr2::req_url_query(filePath = file_path, type = type) |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}
