# Cloudfront Identity
resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "Cloudfront s3 access"
}


# Build Cloudfront distribution
resource "aws_cloudfront_distribution" "this" {
  enabled         = true
  is_ipv6_enabled = true
  comment         = "Distribution to serve Static Website S3 origin"

  # Allowed domains
  # aliases = var.cloudfront_aliases

  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution#price_class
  # This priceclass only allow distribution in America and Europe | Keep Cheap for this example
  price_class = "PriceClass_100"

  default_root_object = "index.html"
  origin {
    domain_name = var.s3_bucket_regional_domain_name
    origin_id   = var.cloudfront_origin_id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.cloudfront_origin_id

    # TTL set to zero to avoid cache
    min_ttl     = 0
    default_ttl = 0
    max_ttl     = 0
    compress    = true

    # Security
    viewer_protocol_policy = "redirect-to-https"

    # This static site dont need/allow any type of values
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  # Additional Cache behavior
  ordered_cache_behavior {
    path_pattern     = "/"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = var.cloudfront_origin_id

    # 30 minutes TTL
    min_ttl     = 0
    default_ttl = 1800
    max_ttl     = 1800
    compress    = true

    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    # ssl_support_method  = "sni-only"
    # acm_certificate_arn = var.acm_certificate_arn
    # Using the default cloudfront certificate
    cloudfront_default_certificate = true
  }
}

# Allow Cloudfront to access s3 objects
data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${var.s3_bucket_arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.this.iam_arn]
    }
  }
}

# Adding Access Policy to s3 bucket
resource "aws_s3_bucket_policy" "this" {
  bucket = var.s3_bucket_name
  policy = data.aws_iam_policy_document.s3_policy.json
}