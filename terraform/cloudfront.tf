resource "aws_cloudfront_distribution" "cloudfront_distro" {
  origin {
    domain_name              = aws_s3_bucket_website_configuration.static_website.website_endpoint
    origin_id                = "${var.root_domain_name}-Origin"
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1","TLSv1.1","TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  retain_on_delete    = true

/* aliases = ["${var.root_domain_name}", "www.${var.root_domain_name}"] */ 

  default_cache_behavior {
    target_origin_id = "${var.root_domain_name}-Origin"
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]

    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.sichello_cert_arn_us_east_1
    ssl_support_method = "sni-only"
  }

  price_class         = "PriceClass_100"
}