
resource "aws_apigatewayv2_domain_name" "sichello-API" {
  domain_name = "api.${var.root_domain_name}"

  domain_name_configuration {
    certificate_arn = var.sichello_cert_arn_ca_central_1
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

resource "aws_apigatewayv2_api" "sichello-visitors-API" {
  name          = "sichello-visitors"
  protocol_type = "HTTP"

  cors_configuration {
    allow_headers     = ["*"]
    allow_methods     = ["*"]
    allow_origins     = ["*"]
    expose_headers    = ["*"]
    max_age           = "300"
  }
}

resource "aws_apigatewayv2_integration" "visitorAPI-integration" {
  api_id           = aws_apigatewayv2_api.sichello-visitors-API.id
  integration_type = "AWS_PROXY"

  connection_type           = "INTERNET"
  description               = "Lambda integration"
  integration_uri           = aws_lambda_function.visitorAPI_lambda_function.invoke_arn
}
