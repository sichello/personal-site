resource "aws_s3_bucket" "sichello_bucket" {
  bucket = "sichello.com-terraform"
}

resource "aws_s3_object" "website_dir" {
  for_each = fileset("../website/", "**/*.*")
  bucket = aws_s3_bucket.sichello_bucket.id
  key    = each.key
  source = "${each.value}"
}

resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.sichello_bucket.id

  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

