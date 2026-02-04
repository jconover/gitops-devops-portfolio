locals {
  cluster_name = coalesce(var.cluster_name, "${var.name}-eks")
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 20.0"
  cluster_name    = local.cluster_name
  cluster_version = var.cluster_version
  subnet_ids      = var.subnet_ids
  vpc_id          = var.vpc_id

  eks_managed_node_groups = var.managed_node_groups
  tags                    = var.tags
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "kubeconfig" {
  value     = module.eks.cluster_endpoint
  sensitive = true
}
