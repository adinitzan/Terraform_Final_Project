# AWS
provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source             = "./vpc"
  vpc_cidr          = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  common_tags = var.common_tags
}

module "ecr" {
  source  = "./ECR"
  common_tags = var.common_tags
}

module "eks" {
  source  = "./eks"
  vpc_id  =var.vpc_id
  subnet_ids = module.vpc.subnet_ids
  role_arn   = module.security.eks_role_arn
  common_tags = var.common_tags
  node_role_arn   = module.ecr.eks_node_role_arn
}

module "security" {
  source  = "./security"
  vpc_id  = module.vpc.vpc_id
}

module "rds" {
  source            = "./modules/rds"
  vpc_id            = module.vpc.vpc_id
  vpc_cidr_block    = var.vpc_cidr_block
  subnet_ids        = var.subnet_ids
  eks_security_group_id = module.security.eks_security_group_id
  db_username       = var.db_username
  db_password       = var.db_password
  db_name           = var.db_name
  db_engine         = var.db_engine
  db_engine_version = var.db_engine_version
  common_tags       = var.common_tags
}

output "eks_cluster_name_in_main" {
  value = module.eks.eks_cluster_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

terraform {
  backend "local" {
    path = "../terraform.tfstate"
  }
}
