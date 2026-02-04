variable "name" {
  description = "Prefix used for naming VPC resources"
  type        = string
}

variable "cidr_block" {
  description = "Primary CIDR block for the VPC"
  type        = string
}

variable "tags" {
  description = "Common tags for the VPC"
  type        = map(string)
  default     = {}
}
