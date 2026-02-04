variable "name" {
  description = "Environment or workload name"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for Jenkins host"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.large"
}

variable "subnet_id" {
  description = "Subnet for Jenkins host"
  type        = string
}

variable "security_group_ids" {
  description = "Security groups applied to the instance"
  type        = list(string)
  default     = []
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
