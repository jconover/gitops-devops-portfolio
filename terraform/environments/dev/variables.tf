variable "region" {
  description = "AWS region"
  type        = string
}

variable "name" {
  description = "Environment name"
  type        = string
}

variable "cidr_block" {
  description = "Primary VPC CIDR"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones for subnets"
  type        = list(string)
}

variable "eks_node_ingress_cidrs" {
  description = "Allowed CIDRs for EKS node SG"
  type        = list(string)
}

variable "managed_node_groups" {
  description = "Map of managed node group definitions"
  type        = any
}

variable "managed_node_group_defaults" {
  description = "Defaults merged into each node group"
  type        = map(any)
  default     = {}
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.34"
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
