locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Owner       = var.owner
  }

  user_data = filebase64("${path.module}/../../scripts/user_data.sh")
}

# ---------------------------------------------------------------- network

module "network" {
  source = "../../modules/network"

  project_name        = var.project_name
  environment         = var.environment
  aws_region          = var.aws_region
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  app_subnet_cidrs    = var.app_subnet_cidrs
  db_subnet_cidrs     = var.db_subnet_cidrs
  azs                 = var.azs
  tags                = local.common_tags
}

# --------------------------------------------------------------- security

module "security" {
  source = "../../modules/security"

  project_name    = var.project_name
  environment     = var.environment
  vpc_id          = module.network.vpc_id
  vpc_cidr        = var.vpc_cidr
  create_iam_role = var.enable_iam
  tags            = local.common_tags
}

# ---------------------------------------------------------- load-balancer

module "load_balancer" {
  source = "../../modules/load-balancer"

  project_name          = var.project_name
  environment           = var.environment
  vpc_id                = module.network.vpc_id
  public_subnet_ids     = module.network.public_subnet_ids
  alb_security_group_id = module.security.alb_security_group_id
  tags                  = local.common_tags
}

# ---------------------------------------------------------------- compute

module "compute" {
  source = "../../modules/compute"

  project_name          = var.project_name
  environment           = var.environment
  instance_type         = var.instance_type
  app_subnet_ids        = module.network.app_subnet_ids
  app_security_group_id = module.security.app_security_group_id
  instance_profile_name = module.security.instance_profile_name
  target_group_arn      = module.load_balancer.target_group_arn
  min_size              = var.min_size
  max_size              = var.max_size
  user_data             = local.user_data
  tags                  = local.common_tags
}

# --------------------------------------------------------------- database

module "database" {
  count  = var.enable_database ? 1 : 0
  source = "../../modules/database"

  project_name         = var.project_name
  environment          = var.environment
  db_subnet_ids        = module.network.db_subnet_ids
  db_security_group_id = module.security.db_security_group_id
  db_instance_class    = var.db_instance_class
  multi_az             = false
  db_master_password   = var.db_master_password
  tags                 = local.common_tags
}

# ---------------------------------------------------------------- storage

data "aws_caller_identity" "current" {}

module "storage" {
  count  = var.enable_storage ? 1 : 0
  source = "../../modules/storage"

  project_name  = var.project_name
  environment   = var.environment
  bucket_name   = "${var.project_name}-${var.environment}-assets-${data.aws_caller_identity.current.account_id}"
  force_destroy = true
  tags          = local.common_tags
}
