terraform {
  backend "s3" {
    bucket         = "gitops-devops-portfolio-tfstate"
    key            = "envs/dev/terraform.tfstate"
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

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  jenkins_ami = coalesce(var.jenkins_ami_id, data.aws_ami.ubuntu.id)
  argocd_ami  = coalesce(var.argocd_ami_id, data.aws_ami.ubuntu.id)
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
  source                = "../../modules/eks"
  name                  = var.name
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.private_subnet_ids
  cluster_version       = var.cluster_version
  managed_node_group_defaults = merge(
    var.managed_node_group_defaults,
    {
      additional_security_groups = [module.vpc.eks_node_security_group_id]
    },
  )
  managed_node_groups = var.managed_node_groups
  tags                = local.tags
}

module "jenkins" {
  source     = "../../modules/jenkins"
  name       = var.name
  ami_id     = local.jenkins_ami
  instance_type = var.jenkins_instance_type
  subnet_id  = module.vpc.public_subnet_ids[0]
  vpc_id     = module.vpc.vpc_id
  key_name   = var.key_name
  allowed_ssh_cidrs  = var.admin_cidr_blocks
  allowed_http_cidrs = var.jenkins_ui_cidrs
  tags       = local.tags
}

module "argocd_host" {
  source     = "../../modules/argocd_host"
  name       = var.name
  ami_id     = local.argocd_ami
  instance_type = var.argocd_instance_type
  subnet_id  = module.vpc.public_subnet_ids[1]
  vpc_id     = module.vpc.vpc_id
  key_name   = var.key_name
  allowed_ssh_cidrs  = var.admin_cidr_blocks
  allowed_http_cidrs = var.argocd_ui_cidrs
  tags       = local.tags
}

output "jenkins_public_ip" {
  value = module.jenkins.public_ip
}

output "argocd_public_ip" {
  value = module.argocd_host.public_ip
}
