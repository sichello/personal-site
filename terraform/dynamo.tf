resource "aws_dynamodb_table" "dynamodb-table" {
  name           = "visitors"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "site"
  table_class    = "STANDARD_INFREQUENT_ACCESS"

  attribute {
    name = "site"
    type = "S"
  }

    attribute {
    name = "count"
    type = "N"
  }
}