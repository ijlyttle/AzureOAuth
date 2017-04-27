#' Generate an OAuth2.0 token for a native Azure app.
#'
#' This is a wrapper to [httr::oauth2.0_token()], dedicated to Azure OAuth access.
#'
#' The `tenant_id` is used to build the endpoint using [oauth_endpoint_azure()].
#' The `application_id` and (optional) `name` are used to build the
#' app using [httr::ouath_app()].
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

  app <- oauth_app(appname = name, key = application_id, secret = NULL)

  oauth2.0_token(
    endpoint = endpoint,
    app = app,
    user_params = user_params,
    use_oob = use_oob,
    ...
  )
}

