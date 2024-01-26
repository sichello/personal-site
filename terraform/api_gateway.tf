
resource "aws_apigatewayv2_domain_name" "sichello-API" {
  domain_name = "api.${var.root_domain_name}"

  domain_name_configuration {
    certificate_arn = var.sichello_cert_arn_ca_central_1
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

resource "aws_apigatewayv2_api_mapping" "mapping" {
  api_id      = s_apigatewayv2_api.sichello-visitors-API.id
  domain_name = aws_apigatewayv2_domain_name.sichello-API.id
  stage       = aws_apigatewayv2_stage.prod_stage.id
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

# Lambda integration
resource "aws_apigatewayv2_integration" "visitorAPI-integration" {
  api_id           = aws_apigatewayv2_api.sichello-visitors-API.id
  integration_type = "AWS_PROXY"

  connection_type           = "INTERNET"
  description               = "Lambda integration"
  integration_uri           = aws_lambda_function.visitorAPI_lambda_function.invoke_arn
}

# Create visitors route
resource "aws_apigatewayv2_route" "visitors_route" {
  api_id    = aws_apigatewayv2_api.sichello-visitors-API.id
  route_key = "ANY /visitors"
  target    = "integrations/${aws_apigatewayv2_integration.visitorAPI-integration.id}"
}

# Deploy it 
resource "aws_apigatewayv2_stage" "prod_stage" {
  api_id      = aws_apigatewayv2_api.sichello-visitors-API.id
  name        = "prod"
  auto_deploy = true
}