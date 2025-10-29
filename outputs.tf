output "load_balancer_dns" {
  value = module.compute.alb_dns_name
}

output "rds_endpoint" {
  value = module.database.db_endpoint
}

output "cognito_domain_url" {
  value = module.auth.domain_url
}

output "cloudfront_distribution" {
  value = module.edge.cloudfront_domain
}