module "storage" {
  source                              = "git::https://github.com/0xdbe-terraform/terraform-aws-s3-behind-cf.git?ref=v1.0.0"
  application_environment             = local.application_environment
  application_name                    = local.application_name
  application_owner                   = local.application_owner
  application_content_security_policy = local.application_content_security_policy
}