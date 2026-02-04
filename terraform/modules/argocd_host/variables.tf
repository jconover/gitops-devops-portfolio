variable "name" {
  description = "Environment or workload name"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for Argo CD host"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t3.medium"
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "allowed_ssh_cidrs" {
  description = "CIDR blocks allowed SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "allowed_http_cidrs" {
  description = "CIDR blocks allowed Argo CD UI"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "instance_profile" {
  description = "IAM instance profile"
  type        = string
  default     = null
}

variable "key_name" {
  description = "SSH key name"
  type        = string
  default     = null
}

variable "user_data" {
  description = "Bootstrap script"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
