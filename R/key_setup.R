#' Helper to set up IonReporter envvar
#' @return boolean. Has key been set? Will return FALSE after setup since
#'   session hasn't been restarted
#' @export
key_setup <- function() {
  if (!has_key()) {
    cli::cli_alert_warning(
      "The environment variable {.envvar IONREPORTER_KEY} appears to be unset"
    )
    cli::cli_alert_info(
      "You can find your API token by logging in to IonReporter ",
      "and clicking the gear in the upper right-hand corner."
    )
    cli::cli_alert_warning(
      "This is a private key. Do not share it or include it in your code."
    )
    cli::cli_text("Add the following line to your {.file .Renviron}:")
    cli::cli_text("IONREPORTER_KEY=your-key-from-ionreporter-here")
    open_renviron <- usethis::ui_yeah(
      "Would you like to open your .Renviron now?",
      "Yes", "No", 1, 1, shuffle = FALSE
    )
    if (open_renviron) {
      usethis::edit_r_environ()
      cli::cli_alert_info("Restart your R session for it to take effect")
    }
  }
  has_key()
}

has_key <- function() Sys.getenv("IONREPORTER_KEY") != ""

get_key <- function() {
  if (!has_key()) {
    key_setup()
    cli::cli_abort("{.envvar IONREPORTER_KEY not detected}")
  }
  Sys.getenv("IONREPORTER_KEY")
}
