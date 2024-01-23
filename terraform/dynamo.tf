resource "aws_dynamodb_table" "sichello-dynamodb-table" {
  name           = "visitors"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "site"
  table_class    = "STANDARD_INFREQUENT_ACCESS"

  attribute {
    name = "site"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "sichello" {
  table_name = aws_dynamodb_table.sichello-dynamodb-table.name
  hash_key   = aws_dynamodb_table.sichello-dynamodb-table.hash_key

  item = jsonencode({
    "site": {"S": "sichello.com"},
    "count": {"N": "0"}
  })
}