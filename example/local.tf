locals {
  application_environment             = "test"
  application_name                    = "hello"
  application_owner                   = "0xdbe"
  application_content_security_policy = [
    "img-src 'self'",
    "manifest-src 'self'",
    "script-src 'self'",
    "style-src 'self' 'unsafe-inline'"
  ]
}