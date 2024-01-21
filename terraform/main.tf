resource "aws_s3_bucket" "sichello_bucket" {
  bucket = "sichello.com-terraform"
}

resource "aws_s3_bucket_public_access_block" "public_bucket_access" {
  bucket = aws_s3_bucket.sichello_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.sichello_bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    sid    = "PublicReadGetObject"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      aws_s3_bucket.sichello_bucket.arn,
      "${aws_s3_bucket.sichello_bucket.arn}/*",
    ]
  }
}

module "template_files" {
  source = "hashicorp/dir/template"

  base_dir = "../website"
  template_vars = {
    # Pass in any values that you wish to use in your templates.
    # vpc_id = "vpc-abc123"
  }
}

resource "aws_s3_object" "static_files" {
  for_each = module.template_files.files

  bucket       = aws_s3_bucket.sichello_bucket.id
  key          = each.key
  content_type = each.value.content_type

  # The template_files module guarantees that only one of these two attributes
  # will be set for each file, depending on whether it is an in-memory template
  # rendering result or a static file on disk.
  source  = each.value.source_path
  content = each.value.content

  # Unless the bucket has encryption enabled, the ETag of each object is an
  # MD5 hash of that object.
  etag = each.value.digests.md5
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

