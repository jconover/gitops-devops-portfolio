terraform {
  backend "s3" {
    bucket         = "gitops-devops-portfolio-tfstate"
    key            = "envs/prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "gitops-devops-portfolio-locks"
    encrypt        = true
  }
}

module "vpc" {
  source     = "../../modules/vpc"
  name       = "prod"
  cidr_block = "10.30.0.0/16"
  public_subnet_cidrs = [
    "10.30.1.0/24",
    "10.30.2.0/24",
    "10.30.3.0/24",
  ]
  private_subnet_cidrs = [
    "10.30.11.0/24",
    "10.30.12.0/24",
    "10.30.13.0/24",
  ]
  availability_zones = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
  ]
  eks_node_ingress_cidrs = ["10.30.0.0/16"]
  tags = {
    environment = "prod"
    project     = "gitops-control-plane"
  }
}

module "eks" {
  source                      = "../../modules/eks"
  name                        = "prod"
  vpc_id                      = module.vpc.vpc_id
  subnet_ids                  = module.vpc.private_subnet_ids
  managed_node_group_defaults = {
    additional_security_groups = [module.vpc.eks_node_security_group_id]
  }
  managed_node_groups = {
    primary = {
      desired_size   = 4
      min_size       = 3
      max_size       = 6
      instance_types = ["t3.large"]
      labels = {
        role = "app"
      }
    }
    backend = {
      desired_size   = 2
      min_size       = 2
      max_size       = 4
      instance_types = ["t3a.large"]
      labels = {
        role = "worker"
      }
    }
  }
  tags = {
    environment = "prod"
    project     = "gitops-control-plane"
  }
}
