#' Generate OAuth2.0 token for Azure native app.
#'
#' This is a wrapper to [httr::oauth2.0_token()], dedicated to Azure OAuth access.
#'
#' The `tenant_id` is used to build the endpoint using [oauth_endpoint_azure()].
#' The `application_id` and (optional) `name` are used to build the
#' app using [httr::oauth_app()].
#'
#' On the Azure side, can build the app from the Azure Portal:
#'
#' 1. Go to **Active Directory** > **App registrations** >
#'   **New application registration**.
#' 1. For "Application type", choose "Native".
#' 1. For "Sign-on URL", enter `http://localhost:1410`.
#' 1. Compose this link using `tenant_id` and `application_id`,
#'   then send to your Azure Tenant adminstrator (maybe that's you)
#'   to activate the permissions:
#'   `https://login.microsoftonline.com/{tenant_id}/adminconsent?client_id={application_id}&state=12345&redirect_uri=http://localhost/`
#'
#' For more information on "activating" your app, please see [this Azure documentation](https://docs.microsoft.com/en-us/azure/active-directory/develop/active-directory-v2-scopes).
#'
#' @param tenant_id     character, tenant id issued by Azure
#' @param application_id character, application id issued by Azure
#' @param name          character, name of application (optional)
#' @param user_params   named list, see [httr::oauth2.0_token()]
#' @param use_oob       logical, see [httr::oauth2.0_token()]
#' @param ...           other arguments passed to [httr::oauth2.0_token()]
#'
#' @return A `Token2.0` reference class (RC) object, returned by [httr::oauth2.0_token()].
#' @examples
#' \dontrun{
#'   oauth_token_azure(
#'     tenant_id = "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee",
#'     application_id = "ffffffff-gggg-hhhh-iiii-jjjjjjjjjjjj",
#'     name = "test-app"
#'   )
#' }
#' @export
#'
oauth_token_azure <- function(tenant_id, application_id, name = NULL,
                              user_params = list(
                                resource = "https://management.core.windows.net/"
                              ),
                              use_oob = FALSE, ...) {

  endpoint <- oauth_endpoint_azure(tenant_id)

  app <- httr::oauth_app(appname = name, key = application_id, secret = NULL)

  httr::oauth2.0_token(
    endpoint = endpoint,
    app = app,
    user_params = user_params,
    use_oob = use_oob,
    ...
  )
}

#' Generate OAuth2.0 token for Azure service account.
#'
#' As described in [`httr::oauth_service_token()`], service accounts
#' provide a way of using OAuth2 without user intervention.
#'
#' At some point in the near future, describe how to make a Azure web-app.
#'
#' @inheritParams oauth_token_azure
#' @param application_secret character, key issued by the account
#' @param resource character, resource requested
#'
#' @return A `TokenServiceAccountAzure` reference class (RC) object.
#' @examples
#' \dontrun{
#'   oauth_service_token_azure(
#'     tenant_id = "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee",
#'     application_id = "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee",
#'     application_secret = "foofoofoofoofoofoofoofoofooooo"
#'   )
#' }
#' @export
#'
oauth_service_token_azure <-
  function(tenant_id, application_id, application_secret,
           resource = "https://management.core.windows.net/") {

  TokenServiceAccountAzure$new(
    endpoint = oauth_endpoint_azure(tenant_id),
    secrets = list(
      application_id = application_id,
      application_secret = application_secret
    ),
    params = list(resource = resource)
  )
}

#' OAuth token objects for Azure service app.
#'
#' @seealso [`httr::Token-class`]
#'
#' @docType class
#' @keywords internal
#' @format An R6 class object.
#' @importFrom R6 R6Class
#' @export
#' @name Token-class
#'
TokenServiceAccountAzure <- R6::R6Class(
  "TokenServiceAccountAzure",
  inherit = httr::TokenServiceAccount,
  list(
    initialize = function(endpoint, secrets, params) {
      self$endpoint <- endpoint

      # secrets contains: application_id, application_secret
      self$secrets <- secrets

      #  for example: resource = https://management.core.windows.net/
      self$params <- params

      self$refresh()
    },
    refresh = function() {
      self$credentials <-
        init_oauth_service_account_azure(
          endpoint = self$endpoint,
          application_id = self$secrets$application_id,
          application_secret = self$secrets$application_secret,
          resource = self$params$resource
        )
      self
    }
  )
)
