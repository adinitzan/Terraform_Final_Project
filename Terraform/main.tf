# AWS
provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source             = "./vpc"
  vpc_cidr          = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "eks" {
  source  = "./eks"
  vpc_id  = module.vpc.vpc_id
  subnet_ids = [module.vpc.public_subnet_id, module.vpc.private_subnet_id]
}

module "security" {
  source  = "./security"
  vpc_id  = module.vpc.vpc_id
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