variable "name" {
  description = "Prefix used for naming VPC resources"
  type        = string
}

variable "cidr_block" {
  description = "Primary CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  validation {
    condition     = length(var.public_subnet_cidrs) > 0
    error_message = "At least one public subnet CIDR must be supplied."
  }
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
  validation {
    condition     = length(var.private_subnet_cidrs) > 0 && length(var.private_subnet_cidrs) == length(var.public_subnet_cidrs)
    error_message = "Private subnet CIDRs must be provided and match the number of public subnets."
  }
}

variable "availability_zones" {
  description = "Optional availability zones for subnet placement"
  type        = list(string)
  default     = []
}

variable "eks_node_ingress_cidrs" {
  description = "CIDR blocks allowed to reach the EKS worker security group"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Common tags for the VPC"
  type        = map(string)
  default     = {}
}
