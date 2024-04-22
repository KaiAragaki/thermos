#' Get a link to a VCF file
#'
#' If you want to download a VCF to a file, `download_vcf` is a better option.
#'
#' `download_vcf` provides a slightly more ergonomic way to directly download
#' files, rather than just get links to them.
#'
#' @param type character. Either "sample" (the default) or "analysis"
#' @param name character. See details.
#' @param id character. Optional. ID of analysis.
#' @param start_date,end_date character. Optional. YYYY-MM-DD format.
#' @param duration Optional. Parameter to filter the results by days/months.
#'   Valid value starts with "-" follow by a numeric value and ending with "d"
#'   or "m"
#' @param exclude Optional. Can be "unfilteredvariants", "filteredvariants", or
#'   NULL. If NULL (default), downloads both.
#' @param dest Where the file should be saved. Should generally be a .zip. If
#'   null, will be saved as a tempfile with a `.zip` extension
#' @param ... Additional arguments passed to `getvcf`.
#'
#' @return
#' - `download_vcf`: The path to the downloaded file
#'
#' - `getvcf`: A JSON-like list containing the link to download the file, the
#'   name, and the id of the analysis that the sample was in
#'
#' @details Sample names are the names in the 'Sample' field in under the
#'   'Samples' tab on IonReporter. They are also under the 'samples' column in
#'   the output of `get_analysis_details`, *not* the 'name' column.
#'
#' Analysis names can also be used to select a vcf to download/get links to
#' download. They exist in the 'name' column in the output of
#' `get_analysis_details`
#'
#' Although the original API documentation seems to imply that the `name`
#' argument isn't needed if `type == "analysis"`, it appears that it is still
#' needed.
#'
#' All other arguments - except `exclude` - are further filters of the hits
#' where `type` and `name` match.
#'
#' I wish I could give a better explanation of "duration" but honestly the API
#' documentation was sparse and gave no examples
#'
#' @export
getvcf <- function(type = c("sample", "analysis"),
                   name,
                   id = NULL,
                   start_date = NULL,
                   end_date = NULL,
                   duration = NULL,
                   exclude = NULL) {
  type <- rlang::arg_match(type)
  out <- default_req("getvcf") |>
    default_headers() |>
    httr2::req_url_query(
      format = "json", type = type, name = name, id = id,
      start_date = start_date, end_date = end_date, duration = duration,
      exclude = exclude
    )
  out |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}


#' @export
#' @rdname getvcf
get_vcf <- function(...) {
  getvcf(...)
}

#' @export
#' @rdname getvcf
download_vcf <- function(dest = NULL, ...) {
  out <- getvcf(...)
  stringr::str_match(out[[1]]$data_links, "\\?filePath=(.*)$")[1, 2] |>
    download(dest = dest)
}
