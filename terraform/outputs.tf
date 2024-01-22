output "s3_url" {
  value = aws_s3_bucket_website_configuration.static_website.website_endpoint
}
output "cloudfront_url" {
  value = aws_cloudfront_distribution.cloudfront_distro.domain_name
}