## Terraform AWS S3 behind CloudFront

Terraform module to create a bucket S3 to host a Single Page Application (SPA) and expose it via CloudFront.

This module is designed to mininize cost for testing purpose.
So that, some security features can't be enable such as log or custom domain name with certificate.

## Usage

```

locals {
  application_environment  = "test"
  application_name         = "hello"
  application_owner        = "me"
  application_csp = [
    "img-src 'self'",
    "manifest-src 'self'",
    "script-src 'self'",
    "style-src 'self' 'unsafe-inline'"
  ]
}

module "storage" {
  source                              = "git::https://github.com/0xdbe-terraform/terraform-aws-s3-behind-cf.git?ref=v1.0.0"
  application_environment             = local.application_environment
  application_name                    = local.application_name
  application_owner                   = local.application_owner
  application_content_security_policy = local.application_csp
}
```