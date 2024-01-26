data "aws_iam_policy_document" "lambda_assume_role_policy" {
  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
      {
        "Effect": "Allow",
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        }
      },
      {
        "Effect": "Allow",
        "Action": [
          "dynamodb:DeleteItem",
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:Scan",
          "dynamodb:UpdateItem"
        ],
        "Resource": "${aws_dynamodb_table.sichello-dynamodb-table.arn}"
      }
    ]
  })
}


resource "aws_iam_role" "lambda_role" {  
  name = "lambda-lambdaRole"  
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

data "archive_file" "python_lambda_package" {  
  type = "zip"  
  source_file = "../lambda_visitorAPI.py" 
  output_path = "lambda_visitorAPI.zip"
}

resource "aws_lambda_function" "visitorAPI_lambda_function" {
        function_name = "visitorAPI"
        filename      = "lambda_visitorAPI.zip"
        source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
        role          = aws_iam_role.lambda_role.arn
        runtime       = "python3.10"
        handler       = "lambda_visitorAPI.lambda_handler"
        timeout       = 10
}