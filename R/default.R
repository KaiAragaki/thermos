default_req <- function(append = NULL,
                        base = "https://ionreporter.thermofisher.com/api/v1") {
  httr2::request(base) |>
    httr2::req_url_path_append(append) |>
    httr2::req_user_agent("thermos (https://github.com/KaiAragaki/thermos)")
}
