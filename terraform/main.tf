resource "aws_s3_bucket" "static_website" {
  bucket = "sichello.com-terraform"  # Change this to a globally unique bucket name

  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Name = "sichello"
  }
}

