resource "aws_dynamodb_table" "dynamodb-table" {
  name           = "visitors"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "site"
  table_class    = "STANDARD_INFREQUENT_ACCESS"
  range_key      = "count"


  attribute {
    name = "site"
    type = "S"
  }
  attribute{
    name = "count"
    type = "N"
  }
}

# module "dynamodb_table" {
#   source   = "terraform-aws-modules/dynamodb-table/aws"

#   name           = "visitors"
#   billing_mode   = "PAY_PER_REQUEST"
#   hash_key       = "site"
#   table_class    = "STANDARD_INFREQUENT_ACCESS"

#   attributes = [
#     {
#         name = "site"
#         type = "S"
#     },
#     {
#         name = "count"
#         type = "N"
#     }
#   ]
# }

