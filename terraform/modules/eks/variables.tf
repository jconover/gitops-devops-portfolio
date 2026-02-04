variable "name" {
  description = "Environment or workload name"
  type        = string
}

variable "cluster_name" {
  description = "Override for EKS cluster name"
  type        = string
  default     = null
}

variable "cluster_version" {
  description = "Desired Kubernetes version"
  type        = string
  default     = "1.34"
}

variable "subnet_ids" {
  description = "Subnets where worker nodes will run"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC identifier"
  type        = string
}

variable "managed_node_groups" {
  description = "Map of EKS managed node group definitions"
  type        = any
  default     = {}
}

variable "managed_node_group_defaults" {
  description = "Defaults applied to all managed node groups"
  type        = map(any)
  default     = {}
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
