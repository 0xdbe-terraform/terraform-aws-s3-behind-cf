resource "random_integer" "suffix" {
  min     = 1
  max     = 999
}

resource "aws_s3_bucket" "main" {
  bucket = "${var.application_name}-${format("%000d",random_integer.suffix.result)}-${var.application_environment}"
  tags = {
    Project     = var.application_name
    Environment = var.application_environment
    Owner       = var.application_owner
  }
}

resource "aws_s3_bucket_acl" "main" {
  bucket = aws_s3_bucket.main.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = aws_s3_bucket.main.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.main.id
  policy = data.aws_iam_policy_document.s3.json
}