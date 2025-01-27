variable "environment" {
  description = "The environment (e.g., development, staging, production)"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
}
