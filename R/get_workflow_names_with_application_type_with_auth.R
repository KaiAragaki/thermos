get_workflow_names_with_application_type_with_auth <- function() {
  default_req("getWorkflowNamesWithApplicationTypeWithAuth") |>
    httr2::req_method("POST") |>
    httr2::req_headers(
      `Content-Type` = "application/x-www-form-urlencoded",
      Authorization = get_key(),
      Version = "52"
    ) |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}
