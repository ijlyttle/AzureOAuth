context("native_token")

test_that("multiplication works", {
  skip_on_cran()
  skip_on_travis()
  skip_if_not(interactive())

  token <- oauth_token_azure(
    tenant_id = Sys.getenv("azure_tenant_id"),
    application_id = Sys.getenv("azure_native_application_id"),
    name = Sys.getenv("azure_native_application_name"),
    cache = FALSE
  )

  expect_is(token, "Token2.0")
})
