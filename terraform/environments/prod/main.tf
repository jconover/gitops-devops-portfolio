terraform {
  backend "s3" {
    bucket         = "gitops-devops-portfolio-tfstate"
    key            = "envs/prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "gitops-devops-portfolio-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}

locals {
  tags = merge({
    environment = var.name
    project     = "gitops-control-plane"
  }, var.tags)
}

module "vpc" {
  source     = "../../modules/vpc"
  name       = var.name
  cidr_block = var.cidr_block
  public_subnet_cidrs    = var.public_subnet_cidrs
  private_subnet_cidrs   = var.private_subnet_cidrs
  availability_zones     = var.availability_zones
  eks_node_ingress_cidrs = var.eks_node_ingress_cidrs
  tags                   = local.tags
}

module "eks" {
  source                      = "../../modules/eks"
  name                        = var.name
  vpc_id                      = module.vpc.vpc_id
  subnet_ids                  = module.vpc.private_subnet_ids
  cluster_version             = var.cluster_version
  managed_node_group_defaults = merge(
    var.managed_node_group_defaults,
    {
      additional_security_groups = [module.vpc.eks_node_security_group_id]
    },
  )
  managed_node_groups = var.managed_node_groups
  tags                = local.tags
}
