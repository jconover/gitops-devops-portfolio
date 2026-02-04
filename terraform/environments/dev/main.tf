terraform {
  backend "s3" {
    bucket         = "gitops-devops-portfolio-tfstate"
    key            = "envs/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "gitops-devops-portfolio-locks"
    encrypt        = true
  }
}

module "vpc" {
  source     = "../../modules/vpc"
  name       = "dev"
  cidr_block = "10.10.0.0/16"
  public_subnet_cidrs = [
    "10.10.1.0/24",
    "10.10.2.0/24",
  ]
  private_subnet_cidrs = [
    "10.10.11.0/24",
    "10.10.12.0/24",
  ]
  availability_zones = [
    "us-east-1a",
    "us-east-1b",
  ]
  eks_node_ingress_cidrs = [
    "10.10.0.0/16",
  ]
  tags = {
    environment = "dev"
    project     = "gitops-control-plane"
  }
}

module "eks" {
  source                = "../../modules/eks"
  name                  = "dev"
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.private_subnet_ids
  managed_node_groups   = {}
  tags = {
    environment = "dev"
    project     = "gitops-control-plane"
  }
}
