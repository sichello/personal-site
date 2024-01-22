# module "cdn" {
#   source = "terraform-aws-modules/cloudfront/aws"

#   aliases = ["sichello.com","www.sichello.com"]

#   comment             = "sichello.com CloudFront"
#   enabled             = true
#   is_ipv6_enabled     = true
#   price_class         = "PriceClass_100"
#   retain_on_delete    = false
#   wait_for_deployment = false

# #  create_origin_access_identity = true
# #  origin_access_identities = {
# #    s3_bucket_one = "My awesome CloudFront can access"
# #  }

# #   origin = {
# #     sichello_static = {
# #       domain_name = aws_s3_bucket_website_configuration.static_website.website_endpoint
# #       custom_origin_config = {
# #         http_port              = 80
# #         https_port             = 443
# #         origin_protocol_policy = "match-viewer"
# #         origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
# #       }
# #     }

# #  #   s3_one = {
# #  #     domain_name = "my-s3-bycket.s3.amazonaws.com"
# #  #     s3_origin_config = {
# #  #       origin_access_identity = "s3_bucket_one"
# #  #     }
# #  #   }
# #   }

#   # default_cache_behavior = {
#   #   target_origin_id           = aws_s3_bucket_website_configuration.static_website.website_endpoint
#   #   viewer_protocol_policy     = "allow-all"

#   #   allowed_methods = ["GET", "POST", "OPTIONS"]
#   #   cached_methods  = ["GET", "POST"]
#   #   compress        = true
#   #   query_string    = true
#   # }

#   # viewer_certificate = {
#   #   acm_certificate_arn = "arn:aws:acm:us-east-1:246445056940:certificate/4cd39535-53fd-4b05-bd34-18983ebf7baf"
#   #   ssl_support_method  = "sni-only"
#   # }
# }

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket_website_configuration.static_website.website_endpoint
    origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    origin_id                = "sichelloOrigin"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "sichello.com comment"
  # default_root_object = "index.html"

  # logging_config {
  #   include_cookies = false
  #   bucket          = "mylogs.s3.amazonaws.com"
  #   prefix          = "myprefix"
  # }

  aliases = ["sichello.com", "www.sichello.com"]

  default_cache_behavior {
    allowed_methods  = ["GET", "POST", ]
    cached_methods   = ["GET", "POST"]
    target_origin_id = "sichelloOrigin"

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}