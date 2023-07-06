variable "web_bucket_bucket_regional_domain_name" {}
variable "web_bucket_id" {}

resource aws_cloudfront_distribution static-www {

  origin {
    domain_name = var.web_bucket_bucket_regional_domain_name
    origin_id   = var.web_bucket_id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.static-www.cloudfront_access_identity_path
    }
  }

  enabled = true

  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.web_bucket_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["JP"]
    }
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

resource "aws_cloudfront_origin_access_identity" "static-www" {}