# Equipment Rental AWS Migration

This repository contains Terraform configurations to migrate an Azure-based equipment rental platform to AWS.

It provisions a secure, scalable, and POPIA-compliant infrastructure in the South Africa (af-south-1) region.

## Architecture Overview
Azure Service	AWS Equivalent	Purpose
Azure App Service	AWS ECS (Fargate)	Web/API hosting
Azure SQL Database	Amazon RDS (MySQL/Aurora)	Relational data storage
Azure Blob Storage	Amazon S3	Object storage (documents, images)
Azure Functions	AWS Lambda	Serverless business logic
Azure Service Bus	Amazon SQS	Asynchronous messaging
Azure AD B2C	Amazon Cognito	Customer authentication (B2C)
Azure API Management	Amazon API Gateway	API management & integrations
Azure Front Door	CloudFront + WAF	Global content delivery & web security
Power BI	Amazon QuickSight	Analytics dashboards
Synapse Analytics	Amazon Redshift	Data warehousing & analytics
Azure DevOps	GitHub Actions / CodePipeline	CI/CD pipelines
Azure Backup	AWS Backup	Data backup & resilience
Azure Monitor	Amazon CloudWatch	Observability & monitoring
## Project Structure

├── main.tf                  # Root Terraform composition
├── variables.tf             # Root-level variables
├── outputs.tf               # Key outputs
├── terraform.tfvars         # Environment-specific values
├── modules/                 # Reusable Terraform modules
│   ├── compute/             # ECS cluster & ALB
│   ├── storage/             # S3 buckets
│   ├── database/            # RDS instance
│   ├── auth/                # Cognito user pools (B2C equivalent)
│   └── edge/                # CloudFront + WAF for global access
└── .github/workflows/       # CI/CD GitHub Actions

## Prerequisites

Terraform ≥ 1.5

AWS CLI configured (aws configure)

IAM credentials with sufficient permissions for ECS, RDS, S3, Lambda, Cognito, CloudFront, WAF, and S3/DynamoDB backend

GitHub Actions with OIDC or AWS credentials for CI/CD

🔧 Example terraform.tfvars
project_name = "equipment-rental"
environment  = "prod"
region       = "af-south-1"

tags = {
  Project     = "EquipmentRental"
  Environment = "Production"
  Owner       = "Ops Team"
}

db_username = "admin"
db_password = "CHANGE_ME"

# Deployment
## Create Terraform backend (S3 + DynamoDB)
aws s3 mb s3://equipment-rental-terraform-state --region af-south-1

aws dynamodb create-table \
  --table-name terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region af-south-1

## Terraform commands
terraform init
terraform plan -out=tfplan
terraform apply tfplan

## Outputs

After deployment, Terraform outputs provide key URLs and endpoints:

Output	Description
cloudfront_distribution	CloudFront URL serving the web/mobile app
cognito_domain_url	Cognito hosted UI URL for authentication
rds_endpoint	RDS instance endpoint for the database
s3_bucket_names	S3 bucket names for storage
lambda_function_names	Names of deployed Lambda functions

## Security & Compliance

Cognito handles user authentication securely (MFA optional)

CloudFront + WAF protects ALB from DDoS and OWASP threats

HTTPS enforced everywhere

No public exposure of RDS or S3

Least-privilege IAM roles

Data stored in af-south-1 for POPIA compliance

Backups handled via AWS Backup

## CI/CD

GitHub Actions workflow (.github/workflows/terraform.yml) implements:

Terraform plan on pull requests

Terraform apply on merge to main

State stored securely in S3 with DynamoDB locking

Supports multi-environment deployments


##  License

MIT License © 2025 Equipment Rental Solutions