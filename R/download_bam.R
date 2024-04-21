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
  default_req("downloadBAM") |>
    default_headers() |>
    httr2::req_url_query(filePath = file_path, type = type) |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}
