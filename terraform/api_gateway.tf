resource "aws_apigatewayv2_api" "sichello-visitors-API" {
  name          = "sichello-visitors-API"
  protocol_type = "HTTP"

  cors_configuration = {
    allow_headers     = "*"
    allow_methods     = "*"
    allow_origins     = "*"
    expose_headers    = "*"
    max_age           = "300"
  }
}

