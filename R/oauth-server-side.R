init_oauth_service_account_azure <-
  function(endpoint, application_id, application_secret, resource) {

  body <- list(
    grant_type = "client_credentials",
    resource = resource,
    client_id = application_id,
    client_secret = application_secret
  )

  res <- httr::POST(
    url = endpoint$access,
    body = body,
    encode = "form"
  )
  httr::stop_for_status(res)

  httr::content(res, type = "application/json")
}
