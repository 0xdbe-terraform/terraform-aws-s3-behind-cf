# s3 name
output "application_bucket_id" {
  value = aws_s3_bucket.main.id
}

# URl cloud front
output "application_url" {
  value = aws_cloudfront_distribution.main.domain_name 
}