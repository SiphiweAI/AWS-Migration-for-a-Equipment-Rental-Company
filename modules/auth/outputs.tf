output "user_pool_id" {
  value = aws_cognito_user_pool.main.id
}

output "client_id" {
  value = aws_cognito_user_pool_client.app.id
}

output "domain_url" {
  value = "https://${aws_cognito_user_pool_domain.domain.domain}.auth.${var.region}.amazoncognito.com"
}
