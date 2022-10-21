data "aws_iam_policy_document" "s3" {
  statement {

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.main.iam_arn]
    }

    actions = [
      "s3:ListBucket",
      "s3:GetObject"
    ]
    
    resources = [
      aws_s3_bucket.main.arn,
      "${aws_s3_bucket.main.arn}/*"
    ]

  }
}