resource "aws_route53_record" "sichello_R53" {
  zone_id = var.sichello_R53_zoneId
  name    = var.root_doamin_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cloudfront_distro.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront_distro.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_sichello_R53" {
  zone_id = var.sichello_R53_zoneId
  name    = www.${var.root_doamin_name}
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cloudfront_distro.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront_distro.hosted_zone_id
    evaluate_target_health = false
  }
}