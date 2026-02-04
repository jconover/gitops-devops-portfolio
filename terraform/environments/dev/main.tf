module "vpc" {
  source     = "../../modules/vpc"
  name       = "dev"
  cidr_block = "10.10.0.0/16"
  tags = {
    environment = "dev"
    project     = "gitops-control-plane"
  }
}

module "eks" {
  source                = "../../modules/eks"
  name                  = "dev"
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = [] # filled after subnet resources are added
  managed_node_groups   = {}
  tags = {
    environment = "dev"
    project     = "gitops-control-plane"
  }
}
