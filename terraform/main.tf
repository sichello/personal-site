resource "aws_s3_bucket" "sichello_bucket" {
  bucket = "sichello.com-terraform"
}

resource "aws_s3_object" "provision_website_files" {

#  for_each = fileset("../website/", "**/*.*")
#  bucket = aws_s3_bucket.sichello_bucket.id
#  key    = each.value
#  source = "${each.value}"

  key                    = "index.html"
  bucket                 = aws_s3_bucket.sichello_bucket.id
  source                 = "../website/index.html"
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

