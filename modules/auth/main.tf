# Cognito User Pool (user store)
resource "aws_cognito_user_pool" "main" {
  name = "${var.project_name}-${var.environment}-users"

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  auto_verified_attributes = ["email"]
  mfa_configuration         = "OFF"

  tags = var.tags
}

# App client (for web or mobile apps)
resource "aws_cognito_user_pool_client" "app" {
  name         = "${var.project_name}-app-client"
  user_pool_id = aws_cognito_user_pool.main.id

  generate_secret = true
  allowed_oauth_flows = ["code"]
  allowed_oauth_scopes = [
    "email",
    "openid",
    "profile"
  ]
  allowed_oauth_flows_user_pool_client = true
  callback_urls  = ["https://app.example.com/callback"]
  logout_urls    = ["https://app.example.com/logout"]
  supported_identity_providers = ["COGNITO"]
}

# Hosted UI domain
resource "aws_cognito_user_pool_domain" "domain" {
  domain       = "${var.project_name}-${var.environment}-auth"
  user_pool_id = aws_cognito_user_pool.main.id
}
