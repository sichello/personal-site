resource "aws_route53_record" "regional" {
  zone_id = var.sichello_R53_zoneId
  name    = var.root_doamin_name
  type    = "A"
  ttl     = "60"
  records = ["${aws_cloudfront_distribution.cloudfront_distro.domain_name}"]
}