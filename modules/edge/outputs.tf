output "cloudfront_domain" {
  value = aws_cloudfront_distribution.main.domain_name
}

output "waf_arn" {
  value = aws_wafv2_web_acl.main.arn
}
