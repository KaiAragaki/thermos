genome_view <- function(id = NULL, name = NULL) {
  if (!is.null(id) && !is.null(name)) {
    cli::cli_warn("Both ID and Name specified. Only ID will be used.")
  }

  if (!is.null(name)) {
    name <- paste0(name, "&Version=5.18")
  }

  default_req("genomeView") |>
    default_headers() |>
    httr2::req_url_query(
      id = id, name = I(name)
    )
}
