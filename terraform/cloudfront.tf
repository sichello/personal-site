module "cdn" {
  source = "terraform-aws-modules/cloudfront/aws"

  aliases = ["sichello.com","www.sichello.com"]

  comment             = "sichello.com CloudFront"
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_100"
  retain_on_delete    = false
  wait_for_deployment = false

#  create_origin_access_identity = true
#  origin_access_identities = {
#    s3_bucket_one = "My awesome CloudFront can access"
#  }

  origin = {
    sichello_static = {
      domain_name = aws_s3_bucket_website_configuration.static_website.website_endpoint
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "match-viewer"
        origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      }
    }

 #   s3_one = {
 #     domain_name = "my-s3-bycket.s3.amazonaws.com"
 #     s3_origin_config = {
 #       origin_access_identity = "s3_bucket_one"
 #     }
 #   }
  }

# default_cache_behavior = {
# target_origin_id           = aws_s3_bucket_website_configuration.static_website.website_endpoint
# viewer_protocol_policy     = "allow-all"
# 
# allowed_methods = ["GET", "POST", "OPTIONS"]
# cached_methods  = ["GET", "POST"]
# compress        = true
# query_string    = true
# }

  viewer_certificate = {
    acm_certificate_arn = "arn:aws:acm:us-east-1:246445056940:certificate/4cd39535-53fd-4b05-bd34-18983ebf7baf"
    ssl_support_method  = "sni-only"
  }
}