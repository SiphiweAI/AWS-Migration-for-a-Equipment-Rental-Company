terraform {
  backend "s3" {
    bucket         = "equipment-rental-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "af-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
