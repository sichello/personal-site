resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = "sichello.com-terraform"  # Change this to a globally unique bucket name

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
  
}

