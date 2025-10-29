variable "region" {
  description = "AWS region"
  default     = "af-south-1"
}

variable "project_name" {
  description = "Project prefix for resources"
  default     = "equipment-rental"
}

variable "environment" {
  description = "Deployment environment (dev/stage/prod)"
  default     = "prod"
}

variable "db_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}
