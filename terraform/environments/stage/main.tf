terraform {
  backend "s3" {
    bucket         = "gitops-devops-portfolio-tfstate"
    key            = "envs/stage/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "gitops-devops-portfolio-locks"
    encrypt        = true
  }
}

module "vpc" {
  source     = "../../modules/vpc"
  name       = "stage"
  cidr_block = "10.20.0.0/16"
  public_subnet_cidrs = [
    "10.20.1.0/24",
    "10.20.2.0/24",
  ]
  private_subnet_cidrs = [
    "10.20.11.0/24",
    "10.20.12.0/24",
  ]
  availability_zones = [
    "us-east-1a",
    "us-east-1b",
  ]
  eks_node_ingress_cidrs = ["10.20.0.0/16"]
  tags = {
    environment = "stage"
    project     = "gitops-control-plane"
  }
}

module "eks" {
  source                      = "../../modules/eks"
  name                        = "stage"
  vpc_id                      = module.vpc.vpc_id
  subnet_ids                  = module.vpc.private_subnet_ids
  managed_node_group_defaults = {
    additional_security_groups = [module.vpc.eks_node_security_group_id]
  }
  managed_node_groups = {
    primary = {
      desired_size   = 3
      min_size       = 2
      max_size       = 5
      instance_types = ["t3.large"]
      labels = {
        role = "app"
      }
    }
  }
  tags = {
    environment = "stage"
    project     = "gitops-control-plane"
  }
}
