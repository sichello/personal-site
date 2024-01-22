resource "aws_route53_zone" "zone" {
  name = "${var.root_doamin_name}-test"
}