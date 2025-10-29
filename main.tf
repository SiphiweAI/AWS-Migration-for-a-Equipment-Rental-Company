locals {
  common_tags = {
    Project = var.project_name
    Env     = var.environment
    Owner   = "ITOps"
  }
}

module "network" {
  source       = "./modules/network"
  project_name = var.project_name
  environment  = var.environment
  tags         = local.common_tags
}

module "storage" {
  source       = "./modules/storage"
  project_name = var.project_name
  tags         = local.common_tags
}

module "database" {
  source       = "./modules/database"
  project_name = var.project_name
  subnet_ids   = module.network.private_subnets
  vpc_id       = module.network.vpc_id
  db_password  = var.db_password
  tags         = local.common_tags
}

module "compute" {
  source       = "./modules/compute"
  project_name = var.project_name
  vpc_id       = module.network.vpc_id
  public_subnets  = module.network.public_subnets
  tags         = local.common_tags
}

module "serverless" {
  source       = "./modules/serverless"
  project_name = var.project_name
  tags         = local.common_tags
}

module "messaging" {
  source       = "./modules/messaging"
  project_name = var.project_name
  tags         = local.common_tags
}

module "monitoring" {
  source       = "./modules/monitoring"
  project_name = var.project_name
  tags         = local.common_tags
}

module "auth" {
  source       = "./modules/auth"
  project_name = var.project_name
  environment  = var.environment
  tags         = local.common_tags
}

module "edge" {
  source        = "./modules/edge"
  project_name  = var.project_name
  environment   = var.environment
  origin_domain = module.compute.alb_dns_name
  tags          = local.common_tags
}