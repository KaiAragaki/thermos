#' Download an IonReporter file
#'
#' @param file_path Path where the file is stored on the server. See details.
#' @param type Format of file. By default, file will be downloaded enclosed in a
#'   .zip
#' @param dest Location where the file should be saved. If NULL, will be
#'   downloaded to tempfile.
#'
#' @return Path to downloaded files
#'
#' @export
download <- function(file_path, type = NULL, dest = NULL) {
  if (is.null(dest)) {
    if (is.null(type)) {
      dest <- tempfile(fileext = "zip")
    } else {
      dest <- tempfile()
    }
  }
  default_req("download") |>
    default_headers() |>
    httr2::req_url_query(filePath = file_path, type = type) |>
    httr2::req_perform(path = dest)
  dest
}
