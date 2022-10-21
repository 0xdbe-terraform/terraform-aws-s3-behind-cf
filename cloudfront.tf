
resource "aws_cloudfront_origin_access_identity" "main" {
  comment = "CloudFront OAI for ${var.application_name}"
}

resource "aws_cloudfront_distribution" "main" {

  enabled             = true
  default_root_object = "index.html"

  origin {
    domain_name = aws_s3_bucket.main.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.main.id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.main.cloudfront_access_identity_path
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = var.application_countries
    }
  }

  default_cache_behavior {
    allowed_methods            = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods             = ["GET", "HEAD", "OPTIONS"]
    response_headers_policy_id = aws_cloudfront_response_headers_policy.main.id
    target_origin_id           = aws_s3_bucket.main.id
    viewer_protocol_policy     = "https-only" # other options - https only, http

    forwarded_values {
      headers      = []
      query_string = true

      cookies {
        forward = "all"
      }
    }

  }

  price_class = "PriceClass_100"

  # A trick to redirect all routes to Single Page Application 
  custom_error_response{
    error_caching_min_ttl = 10
    error_code = 404
    response_code = 200
    response_page_path = "/index.html"
  }

  tags = {
    Project     = var.application_name
    Environment = var.application_environment
    Owner       = var.application_owner
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

resource "aws_cloudfront_response_headers_policy" "main" {
  name = "headers-${var.application_name}"
  
  security_headers_config {
    content_security_policy {
      content_security_policy  = "default-src 'none'; ${join("; ", var.application_content_security_policy)};"
      override                 = true
    }
    content_type_options {
      override = true
    }

    frame_options {
      frame_option = "DENY"
      override = true
    }

    referrer_policy {
      referrer_policy = "no-referrer"
      override        = true
    }

    strict_transport_security {
      access_control_max_age_sec = 63072000
      include_subdomains         = false
      preload                    = true
      override                   = true
    }

    xss_protection {
      mode_block = true
      protection = true
      override   = true
    }

    }
  }