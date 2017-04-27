#' Describe an OAuth2.0 endpoint for Azure.
#'
#' This endpoint is designed for use with Azure Datalake Store; however,
#' it may work for other Azure services.
#'
#' This code for this function is based on:
#'
#' - [Azure Datalake Store documentation](https://docs.microsoft.com/en-us/azure/data-lake-store/data-lake-store-get-started-rest-api#how-do-i-authenticate-using-azure-active-directory)
#' - [**httr** demo for Azure](https://github.com/hadley/httr/blob/master/demo/oauth2-azure.r)
#'
#' @param tenant_id character
#'
#' @return endpoint object returned by [httr::oauth_endpoint()]
#' @examples
#'   oauth_endpoint_azure("aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee")
#' @export
#'
oauth_endpoint_azure <- function(tenant_id) {
  httr::oauth_endpoint(
    authorize = file.path("oauth2", "authorize"),
    access = file.path("oauth2", "token"),
    base_url = file.path("https://login.microsoftonline.com", tenant_id)
  )
}
