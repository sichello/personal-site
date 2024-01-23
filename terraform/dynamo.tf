# resource "aws_dynamodb_table" "dynamodb-table" {
#   name           = "visitors"
#   billing_mode   = "PAY_PER_REQUEST"
#   hash_key       = "site"
#   table_class    = "STANDARD_INFREQUENT_ACCESS"

#   attribute {
#     name = "site"
#     type = "S"
#   }
# }
module "dynamodb_table" {
  source   = "terraform-aws-modules/dynamodb-table/aws"

  name           = "visitors"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "site"
  table_class    = "STANDARD_INFREQUENT_ACCESS"

  attributes = [
    {
        name = "site"
        type = "S"
    },
    {
        name = "count"
        type = "N"
    }
  ]
}

