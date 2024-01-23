resource "aws_route53_record" "sichello-R53" {
  zone_id = var.sichello_R53_zoneId
  name    = var.root_domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cloudfront_distro.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront_distro.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www-sichello-R53" {
  zone_id = var.sichello_R53_zoneId
  name    = "www.${var.root_domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cloudfront_distro.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront_distro.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "api-sichello-R53" {
  zone_id = var.sichello_R53_zoneId
  name    = aws_apigatewayv2_domain_name.sichello-API.domain_name
  type    = "A"

  alias {
    name                   = aws_apigatewayv2_domain_name.sichello-API.target_domain_name
    zone_id                = aws_apigatewayv2_domain_name.sichello-API.hosted_zone_id 
    evaluate_target_health = false
  }
}
