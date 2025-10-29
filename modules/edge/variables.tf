variable "project_name" { type = string }
variable "environment"  { type = string }
variable "origin_domain" {
  description = "DNS name of the ALB or S3 bucket to serve through CloudFront"
  type        = string
}
variable "tags" { type = map(string) }
