
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/AzureOAuth)](https://cran.r-project.org/package=AzureOAuth) [![Travis-CI Build Status](https://travis-ci.org/ijlyttle/AzureOAuth.svg?branch=master)](https://travis-ci.org/ijlyttle/AzureOAuth)

AzureOAuth
==========

The purpose of this package is to make it easier to deal with OAuth tokens from Microsoft Azure. Certainly, the **httr** package takes care of a great majority of the headache. It is hope that this package can alleviate any remaining headache.

Azure access
------------

Talk about native apps and service apps.

What we will need
-----------------

Function `oauth_endpoint_azure()` (in file `oauth-endpoint.R`) - this will take `tenant_id` an argument. **done**

Vignette showing how to get things working for `oauth2.0_token()`.

Function `oauth_service_token_azure()` (in file `oauth-token.R`).

R6 class `TokenServiceAccountAzure` (in file `oauth-token.R`).

Function `init_oauth_service_account_azure()` (in file `oauth-server-side.R`)

Vignette showing how to get things working for `oauth_service_token_azure()`.

Code of Conduct
---------------

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
