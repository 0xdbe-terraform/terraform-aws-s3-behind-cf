variable "application_environment" {
  type        = string
  default     = "test"
  description = "environement of your application"
}

variable "application_name" {
  type        = string
  description = "name of your application"
}

variable "application_owner" {
  type        = string
  description = "owner of your application"
}

variable "application_content_security_policy" {
  type    = list(string)
  description = "Content Security Policy for this application"
}

variable "application_countries" {
  type    = list(string)
  description = "countries list for which you want CloudFront either to distribute your content. This option is required to minimize cost."
  default = [ "FR" ]
}