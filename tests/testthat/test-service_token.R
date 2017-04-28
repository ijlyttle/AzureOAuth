context("service_token")

test_that("multiplication works", {
  skip_on_cran()
  skip_on_travis()

  token <-
    oauth_service_token_azure(
      tenant_id = Sys.getenv("azure_tenant_id"),
      application_id = Sys.getenv("azure_service_application_id"),
      application_secret = Sys.getenv("azure_service_application_secret")
    )

  expect_is(token, "TokenServiceAccountAzure")
})
