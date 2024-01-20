resource "aws_s3_bucket" "sichello_bucket" {
  bucket = "sichello.com-terraform"
}

resource "aws_s3_object" "website_dir" {
  key    = "website"
  bucket = aws_s3_bucket.sichello_bucket.id
  source = "website"

  tags = {
    Env = "test"
  }
}

resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.sichello_bucket.id

  index_document {
    suffix = "site_resources/index.html"
  }
  error_document {
    key = "error.html"
  }
}

